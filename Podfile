# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
    end
  end
end

target 'FeedMe' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!


  # Pods for FeedMe
  pod 'GoogleMaps', '~> 3.7.0'

end
