platform :ios, '9.0'
use_frameworks!

target 'Cooxmate' do
  pod 'Realm', '~> 1.1.0'
  pod 'Alamofire', '~> 3.3.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
