platform :ios, '16.0'

target 'swift-app-mobile' do
  use_frameworks!

  pod 'lottie-ios'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
    end
  end
end
