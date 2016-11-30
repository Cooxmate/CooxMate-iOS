platform :ios, '9.0'
use_frameworks!

target 'Cooxmate' do
  pod 'RealmSwift', '~> 1.1.0'
  pod 'Alamofire', ~> 4.0.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
