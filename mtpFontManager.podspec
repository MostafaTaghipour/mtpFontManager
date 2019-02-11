#
# Be sure to run `pod lib lint mtpFontManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'mtpFontManager'
  s.version          = '2.0.0'
  s.summary          = 'A font Manager for iOS to simplify use of custom fonts (support dynamic types).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
mtpFontManager is a font Manager for iOS to simplify use of custom fonts.
mtpFontManager also supports applay custom font entire application, varius font weight and dynamic types styles.
  DESC

  s.homepage         = 'https://github.com/mostafataghipour/mtpFontManager'
  s.screenshots     = 'https://raw.githubusercontent.com/MostafaTaghipour/mtpFontManager/master/screenshots/1.gif', 'https://raw.githubusercontent.com/MostafaTaghipour/mtpFontManager/master/screenshots/2.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mostafa Taghipour' => 'mostafa.taghipour@ymail.com' }
  s.source           = { :git => 'https://github.com/mostafataghipour/mtpFontManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.2'

  s.source_files = 'mtpFontManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'mtpFontManager' => ['mtpFontManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
