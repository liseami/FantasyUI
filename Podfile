# Uncomment the next line to define a global platform for your project
platform :ios, '14.1'

target 'Example' do
    use_frameworks!
    pod "Moya/Combine", '~> 15.0'
    pod "KakaJSON"
    pod "SwiftyJSON"
    pod "Moya"

end

target 'FantasyUI' do
    use_frameworks!
    pod "Moya/Combine", '~> 15.0'
    pod "KakaJSON"
    pod "SwiftyJSON"
    pod "Moya"

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end


