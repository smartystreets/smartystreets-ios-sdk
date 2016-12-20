Pod::Spec.new do |s|
s.name         = 'Smartystreets_iOS_SDK'
s.version      = '1.0.3'
s.summary      = 'A library to help iOS developers easily access the SmartyStreets APIs.'
s.homepage     = 'https://github.com/smartystreets/smartystreets-ios-sdk'
s.author       = { 'SmartyStreets SDK Team' => 'support@smartystreets.com' }
s.license      = { :type => 'Apache 2.0', :file => 'LICENSE' }

public_header_files = 'include/**/SSRequest.h',
                      'include/**/SSZipCodeClient.h',
                      'include/**/SSZipCodeClientBuilder.h',
                      'include/**/SSStreetClient.h',
                      'include/**/SSStreetClientBuilder.h',
                      'include/**/SSSharedCredentials.h'

s.source       = { :git => 'https://github.com/smartystreets/smartystreets-ios-sdk.git', :tag => s.version }
s.source_files = 'Sources/*.{h,m,plist}',
                 'Sources/US_Street/*.{h,m}',
                 'Sources/US_ZipCode/*.{h,m}'

s.ios.deployment_target = '8.4'
end
