#
# Be sure to run `pod lib lint YStaticContentTableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YStaticContentTableView'
  s.version          = '0.1.1'

  s.summary          = 'Cleanly implement a table view much like those in Settings.app, using a simple, convienent block-based syntax.'
  s.description      = <<-DESC
A subclass-able way to cleanly and neatly implement a table view much like those in Settings.app, with nice-looking fields to collect or display information, all using a simple and convienent block-based syntax
                       DESC

  s.homepage         = 'https://github.com/LiZunYuan/YStaticContentTableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leal' => 'codekami@qq.com' }
  s.source           = { :git => 'https://github.com/LiZunYuan/YStaticContentTableView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '6.0'

  s.source_files = 'YStaticContentTableView/Classes/**/*'
end
