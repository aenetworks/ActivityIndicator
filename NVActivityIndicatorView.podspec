Pod::Spec.new do |s|
  s.name         = "NVActivityIndicatorView"
  s.version      = "3.0"
  s.summary      = "A collection of nice loading animations"
  s.homepage     = "https://github.com/aenetworks/ActivityIndicator"
  s.screenshots  = "https://github.com/aenetworks/ActivityIndicator/master/Demo.gif"
  s.license      = { :type => "MIT" }
  s.author             = { "Nguyen Vinh" => "ninjaprox@gmail.com" }
  s.social_media_url   = "http://twitter.com/ninjaprox"

  s.platform     = :ios, '8.0'

  s.source       = { :git => "hhttps://github.com/aenetworks/ActivityIndicator.git", :tag => "v3.0-ae" }
  s.source_files  = "NVActivityIndicatorView/**/*.swift"

  s.frameworks = "UIKit", "QuartzCore"
  s.requires_arc = true
end
