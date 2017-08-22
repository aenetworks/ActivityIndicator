Pod::Spec.new do |s|
  s.name         = "ActivityIndicator"
  s.version      = '3.0.3'
  s.summary      = "A collection of nice loading animations"
  s.homepage     = "https://github.com/aenetworks/ActivityIndicator"
  s.screenshots  = "https://github.com/aenetworks/ActivityIndicator/master/Demo.gif"
  s.license      = { :type => "MIT" }
  s.author             = { "Nguyen Vinh" => "ninjaprox@gmail.com" }
  s.social_media_url   = "http://twitter.com/ninjaprox"

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '10.0'

  s.source       = { :git => "https://github.com/aenetworks/ActivityIndicator.git", :tag => s.version.to_s }
  s.source_files  = "NVActivityIndicatorView/**/*.swift"

  s.frameworks = "UIKit", "QuartzCore"
  s.requires_arc = true
end
