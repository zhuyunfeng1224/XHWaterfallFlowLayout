#
# Be sure to run `pod lib lint XHWaterfallFlowLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XHWaterfallFlowLayout'
  s.version          = '1.0.0'
  s.summary          = '瀑布流 Objective-C'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 一个瀑布流布局，可用于电商产品的陈列.
                       DESC

  s.homepage         = 'https://github.com/zhuyunfeng1224/XHWaterfallFlowLayout'
#s.screenshots     = 'https://github.com/zhuyunfeng1224/XHImageStore/blob/master/XHWaterfallFlowLayout/XHWaterfallFlowLayout_screenshot.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'echo' => 'leitianshi2009@163.com' }
  s.source           = { :git => 'https://github.com/zhuyunfeng1224/XHWaterfallFlowLayout.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XHWaterfallFlowLayout/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XHWaterfallFlowLayout' => ['XHWaterfallFlowLayout/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
