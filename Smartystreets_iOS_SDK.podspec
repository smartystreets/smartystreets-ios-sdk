Pod::Spec.new do |s|
s.name         = 'Smartystreets_iOS_SDK'
s.version      = '1.0.0'
s.summary      = 'A library to help iOS developers easily access the SmartyStreets APIs.'
s.homepage     = 'https://github.com/smartystreets/smartystreets-ios-sdk'
s.license      = 'Apache License, Version 2.0'
s.author       = { 'SmartyStreets SDK Team' => 'support@smartystreets.com' }

s.ios.deployment_target = '8.4'

s.source       = { :git => 'https://github.com/smartystreets/smartystreets-ios-sdk.git', :tag => s.version }
s.source_files = 'Sources/*.{h,m}'
                 'Sources/US_Street/*.{h,m}'
                 'Sources/US_ZipCode/*.{h,m}'
end
