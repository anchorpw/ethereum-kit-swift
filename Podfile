platform :ios, '10.0'

target 'Example' do
    use_frameworks!
    pod 'EthereumKitSwift', :path => './'
    
    target 'EthereumKitSwiftTests' do
        inherit! :search_paths
        pod 'Nimble'
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if !['EthereumKitSwift'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.1'
            end
        end
    end
end
