# Uncomment this line to define a global platform for your project
# platform :ios, '11.0'

source 'https://github.com/xianrenzhuimeng/WMSpec.git'
source 'https://github.com/CocoaPods/Specs.git'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
    end
  end
end

target 'WMBase' do
  # Uncomment this line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
  pod 'AFNetworking'
  pod 'Masonry'
  pod 'MJRefresh'
  pod 'MJExtension'
  pod 'YYKit'
  pod 'MBProgressHUD'
  pod 'SDWebImage'
  pod 'YTKNetwork'
  pod 'QMUIKit'
  pod 'Toast'
 
end
