Pod::Spec.new do |s|
s.name         = 'SmartystreetsSDK'
s.version      = '7.7.2'
s.summary      = 'A library to help iOS developers easily access the SmartyStreets APIs.'
s.homepage     = 'https://github.com/smartystreets/smartystreets-ios-sdk'
s.author       = { 'SmartyStreets SDK Team' => 'support@smartystreets.com' }
s.license      = { :type => 'Apache 2.0', :file => 'LICENSE.md' }

public_header_files = 'include/**/SSSmartyRequest.h',
                      'include/**/SSInternationalStreetClient.h',
                      'include/**/SSUSAutocompleteClient.h',
                      'include/**/SSUSExtractClient.h',
                      'include/**/SSUSStreetClient.h',
                      'include/**/SSUSZipCodeClient.h',
                      'include/**/SSClientBuilder.h',
                      'include/**/SSSharedCredentials.h'

s.source       = { :git => 'https://github.com/smartystreets/smartystreets-ios-sdk.git', :tag => s.version }
s.source_files = 'Sources/*.{h,m}',
                 'Sources/International_Street/*.{h,m}',
                 'Sources/US_Autocomplete/*.{h,m}',
                 'Sources/US_Extract/*.{h,m}',
                 'Sources/US_Street/*.{h,m}',
                 'Sources/US_ZipCode/*.{h,m}'

s.ios.deployment_target = '8.4'
s.osx.deployment_target = '10.10'

end
