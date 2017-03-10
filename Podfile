# Uncomment this line to define a global platform for your project
# platform :ios, '10.0'

use_frameworks!
xcodeproj 'Cartly.xcodeproj'

target 'Cartly' do 

pod 'Alamofire', '~> 4.0'
pod 'AlamofireImage', '~> 3.1'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
end
