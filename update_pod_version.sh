#!/bin/bash

# The purpose of this script is to automate the process of incrementing the version number of 
# this development pods. It provides an abstracted command line interface for specifying a new
# version number, performing the following actions:
#
# – Updating the version number specified in the .podspec file that sits in this pod repository
# – Pushing a tag for the version number (tagged to the commit which modified the podspec)
# – Creating a directory for the new version number in the AE specs repo
# – Copying the podspec file for the previous version to that location and updating the version number
# - Pushing all commits related to the above to Github
#
# The primary benefits of automating this workflow with this script are time saved and the prevention 
# of human error.

# TODO: Add check/clone for local AENetworks specs repo.
# TODO: Replace manual input of new version number with enumerated Major/Minor/Patch options, to prevent typos there as well.
# TODO: Add handling for first time version tagging (e.g. edge case where there are no preexisting tags.

# User I/O

ask() {
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi
	
        read -p "$1 [$prompt] " REPLY </dev/tty

        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi
	
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
	
    done
}

# Convenience Methods

SAVEIFS=$IFS

readPodName() {
	local fname=$1
	while read -r line
	do
		IFS=$SAVEIFS read -ra values <<< "$line"
		if [ "${values[0]}" = "s.name" ]; then
			text=${values[2]}
			pod_name=`echo $text | sed s/[\'\"]//g`
			echo $pod_name
			exit 1
		fi
	done < "$fname"
}

readPodVersion() {
	local fname=$1
	while read -r line
	do
		IFS=$SAVEIFS read -ra values <<< "$line"
		if [ "${values[0]}" = "s.version" ]; then
			text=${values[2]}
			pod_version=`echo $text | sed s/[\'\"]//g`
			echo $pod_version
			exit 1
		fi
	done < "$fname"
}

# Variable declaration

filename=`ls *.podspec`
branch=`git symbolic-ref --short HEAD`
podname=`readPodName $filename`
version=`readPodVersion $filename`
reposPath="$HOME/.cocoapods/repos/aenetworks/Specs"
startPath=`pwd`

# Sync with Github repo

echo ""

echo "======================================================="
echo "Syncing branch with origin..."
echo ""

git pull origin $branch

echo "======================================================="
echo "Syncing tags with origin..."
echo ""

git pull origin --tags

# Prompt user for new version number

echo "======================================================="
echo "REPO    = $podname"
echo "BRANCH  = $branch"
echo "VERSION = $version"
echo ""

echo -n "Enter new version (or blank to cancel): "
read newVersion

chars=${#newVersion}

# Create new pod version with user input

if [ $chars -gt 0 ]; then 
	podPath="$reposPath/$podname"
	versionPath="$podPath/$newVersion"
	specPath="$startPath/$filename"
	echo "======================================================="

	if ask "You entered $newVersion. Do you want to proceed?" Y; then
		echo "======================================================="
		
		echo "Checking if podspec needs update..."
		if [ $version == $newVersion ]; then 
			echo "–– Podspec version is unchanged. No changes made to $filename"
		else
			echo "–– Updating $filename to version $newVersion"
			sed -E -l -i "" "s/^(.*s\.version.*=)(.*)$/\1 \\'$newVersion\\'/g" $filename
		fi
		
		existingTag=`git tag | grep $newVersion`
		echo ""
		echo "Checking for existing tag $newVersion"
		
		if [ "$existingTag" ]; then 
			echo "–– Tag already exists for $newVersion. No tag pushed"
		else
			echo "–– Committing $filename and pushing tag $newVersion to $branch"
			git add $filename
			git commit -m "Updated to Version $newVersion"
			git push origin $branch
			git tag -a $newVersion -m "Version $newVersion"
			git push origin $newVersion
		fi
		targetPath="$versionPath/$filename"
		
		echo ""
		echo "Checking for existing $targetPath"
		
		if [ -d $podPath ] && [ -f $targetPath ]; then
			echo "–– $filename already exists in $versionPath"
			echo "–– No need to create new version in Specs repo" 
		else
			echo "–– Copying $filename to $versionPath"
			cd $podPath
			git pull
			mkdir $newVersion
			cd $newVersion
			cp $specPath .
			git add $filename
			git commit -m "Pushing $podname Version $newVersion"
			git push origin $branch
		fi
	else 
		echo "Version update cancelled. No changes have been saved."
	fi	
fi
