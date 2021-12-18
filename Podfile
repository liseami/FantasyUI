# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Example' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Example

    pod "Moya/Combine", '~> 15.0'
    pod "KakaJSON"
    pod "SwiftyJSON"

end

target 'FantasyUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

    pod "Moya/Combine", '~> 15.0'
    pod "KakaJSON"
    pod "SwiftyJSON"

  target 'FantasyUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
