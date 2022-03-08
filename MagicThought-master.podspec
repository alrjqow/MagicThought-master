#
# Be sure to run `pod lib lint MagicThought-master.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MagicThought-master'
  s.version          = '1.0.0'
  s.summary          = 'A short description of MagicThought-master.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/alrjqow/MagicThought-master'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alrjqow' => 'alrjqow@163.com' }
  s.source           = { :git => 'https://github.com/alrjqow/MagicThought-master.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.resources = ['MagicThought-master/Classes/MagicThought/MTHud/MTHud.bundle', 'MagicThought-master/Classes/MagicThought/Library/TZImagePickerController/TZImagePickerController.bundle']
  s.source_files = 'MagicThought-master/Classes/**/*'
  s.xcconfig = {'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
  
#  s.subspec 'MagicThought' do |ss|
#  ss.source_files = 'MagicThought-master/Classes/MagicThought/**/*'
#  end
  
  # s.resource_bundles = {
  #   'MagicThought-master' => ['MagicThought-master/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'
  s.dependency 'MBProgressHUD'
  s.dependency 'YTKNetwork'
  s.dependency 'SDWebImage'
  s.dependency 'SAMKeychain'
  s.dependency 'IQKeyboardManager'
  s.dependency 'Masonry'
  s.dependency 'Bugly'
  
  
end
