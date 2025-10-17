#
# Be sure to run `pod lib lint CrashKiller.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CrashKiller'
  s.version          = '1.0.0'
  s.summary          = 'CrashKiller（闪退杀手）.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
此防护系统并不能解决所有的崩溃类型，只是对一些[高频crash](#高频crash)进行一一的处理，我们的目的就是降低crash率.
                       DESC

  s.homepage         = 'https://github.com/fengyang0329/CrashKiller.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fengyang0329' => '599086054@qq.com' }
  s.source           = { :git => 'https://github.com/fengyang0329/CrashKiller.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'CrashKiller/Classes/**/*'

  s.public_header_files = 'CrashKiller/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.prefix_header_file = false

end
