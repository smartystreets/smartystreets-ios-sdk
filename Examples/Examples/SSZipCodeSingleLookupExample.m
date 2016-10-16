#import "SSZipCodeSingleLookupExample.h"
#import </Users/oshion/Library/Developer/Xcode/DerivedData/Smartystreets_iOS_SDK-hgqhnhhppaibdnfgaptgxhhngupi/Build/Products/Debug-iphonesimulator/Smartystreets_iOS_SDK.framework/Headers/SSZipCodeClient.h>
#import </Users/oshion/Library/Developer/Xcode/DerivedData/Smartystreets_iOS_SDK-hgqhnhhppaibdnfgaptgxhhngupi/Build/Products/Debug-iphonesimulator/Smartystreets_iOS_SDK.framework/Headers/SSZipCodeClientBuilder.h>

@implementation SSZipCodeSingleLookupExample

- (NSString*)runCode {
    SSZipCodeClient *client = [[[SSZipCodeClientBuilder alloc]
                                initWithAuthId:@"YOUR AUTH-ID HERE"
                                authToken:@"YOUR AUTH-TOKEN HERE"]
                               build];
    
    SSZipCodeLookup *lookup = [[SSZipCodeLookup alloc] init];
    lookup.city = @"Mountain View";
    lookup.state = @"California";
    
    NSError *error = nil;
    [client sendLookup:lookup error:&error];
    
    if (error != nil) {
        //handle
    }
    
    SSResult *result = lookup.result;
    NSArray<SSZipCode*> *zipCodes = result.zipCodes;
    NSArray<SSCity*> *cities = result.cities;
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (cities == nil && zipCodes == nil)
        return [output stringByAppendingString:@"Error getting cities and zip codes."];
    
    for (SSCity *city in cities) {
        [output stringByAppendingString:[@"\nCity: " stringByAppendingString:city.city]];
        [output stringByAppendingString:[@"State: " stringByAppendingString:city.state]];
        [output stringByAppendingString:[@"Mailable City: " stringByAppendingString:city.mailableCity ? @"YES" : @"NO"]];
    }
    
    for (SSZipCode *zip in zipCodes) {
        [output stringByAppendingString:[@"\nZIP Code: " stringByAppendingString:zip.zipCode]];
        NSNumber *latitude = [NSNumber numberWithDouble:zip.latitude];
        NSNumber *longitute = [NSNumber numberWithDouble:zip.longitude];
        [output stringByAppendingString:[@"Latitue: " stringByAppendingString:[latitude stringValue]]];
        [output stringByAppendingString:[@"Longitude: " stringByAppendingString:[longitute stringValue]]];
    }
    
    return output;
}

@end
