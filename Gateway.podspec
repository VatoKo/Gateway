#
#  Be sure to run `pod spec lint Gateway.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "Gateway"
  spec.version      = "0.0.1"
  spec.summary      = "Simple, elegant, easy-to-use network layer for Swift."
  spec.description  = <<-DESC
  Gateway is very simple, elegant and easy-to-use network layer for Swift, which will help you make HTTP requests, receive responses and parse received data into Swift's native objects.
                   DESC
  spec.homepage = 'https://github.com/VatoKo/Gateway'
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.authors = { "VatoKo" => "vkost16@freeuni.edu.ge", "irakli" => "ichku14@freeuni.edu.ge" }
  spec.social_media_url = "https://www.facebook.com/VaTo.Kostava"
  spec.platform = :ios, "12.4"
  spec.swift_version = '5.1'
  spec.source = { :git => "https://github.com/VatoKo/Gateway.git", :tag => "#{spec.version}" }
  spec.source_files  = "Gateway"
  
end
