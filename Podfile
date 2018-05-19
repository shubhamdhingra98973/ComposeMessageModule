# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ComposeMessageModule' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
    pod 'SJSegmentedScrollView', '1.3.8'
    pod 'R.swift'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'ObjectMapper'
    pod 'EZSwiftExtensions'
    pod 'SwiftMessages'
    pod 'Toaster'
    pod 'NVActivityIndicatorView'
    pod 'RMMapper'
    #pod 'Material'
    pod 'IQKeyboardManager'
    pod 'IBAnimatable'
    
  # Pods for ComposeMessageModule

# Enable DEBUG flag in Swift for SwiftTweaks
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'EZSwiftExtensions'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end
end
