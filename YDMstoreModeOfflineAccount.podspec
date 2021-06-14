#
#  Be sure to run `pod spec lint YDMstoreModeOfflineAccount.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "YDMstoreModeOfflineAccount"
  spec.version      = "1.3.6"
  spec.summary      = "A short description of YDMstoreModeOfflineAccount."
  spec.homepage     = "http://yourdev/YDMstoreModeOfflineAccount"

  spec.license          = "MIT"
  spec.author       = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.swift_version    = "5.0"
  spec.platform         = :ios, "11.0"
  spec.source           = { :git => "https://github.com/Hennrich-Your-Dev/YDMstoreModeOfflineAccount.git", :tag => "#{spec.version}" }

  spec.source_files     = "YDMstoreModeOfflineAccount/**/*.{h,m,swift}"
  spec.resources        = [
    "YDMstoreModeOfflineAccount/**/*.{xib,storyboard,json,xcassets,html}",
    "YDMstoreModeOfflineAccount/*.{xib,storyboard,json,xcassets,html}"
  ]

  spec.dependency "YDB2WIntegration", "~> 1.3.0"
  spec.dependency "YDUtilities", "~> 1.3.0"
  spec.dependency "YDExtensions", "~> 1.3.0"
  spec.dependency "YDB2WAssets", "~> 1.3.0"
  spec.dependency "YDB2WComponents", "~> 1.3.0"
  spec.dependency "YDMOfflineOrders", "~> 1.3.0"
  spec.dependency "YDB2WServices", "~> 1.3.0"
  spec.dependency "YDSpacey", "~> 1.3.0"

  spec.dependency "Hero"

end
