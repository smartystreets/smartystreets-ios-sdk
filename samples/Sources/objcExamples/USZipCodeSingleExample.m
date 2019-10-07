#import "USZipCodeSingleExample.h"

@interface USZipCodeSingleExample ()

@end

@implementation USZipCodeSingleExample

- (NSString *)run {
    USZipCodeClient* client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].buildUsZIPCodeApiClient;
    
    //        Documentation for input fields can be found at:
    //        https://smartystreet.com/docs/us-zipcode-api#input-fields
    USZipCodeLookup *lookup = [[USZipCodeLookup alloc] init];
    lookup.inputId = @"dfc33cb6-829e-4fea-aa1b-b6d6580f0817"; // Optional ID from your system
    lookup.city = @"Mountain View";
    lookup.state = @"California";
    lookup.zipcode = @"94043";
    
    NSError *error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (error != nil) {
        [output appendFormat:@"Domain: %@\n", error.domain];
        [output appendFormat:@"Error Code: %ld\n", (long)error.code];
        [output appendFormat:@"Description: %@\n", [error localizedDescription]];
        return output;
    }
    
    USZipCodeResult* result = lookup.result;
    NSArray<USZipCode*>* zipCodes = result.zipCodes;
    NSArray<USCity*>* cities = result.cities;
    
    if (success) {
        [output appendString:@"Successfully retrieved ZipCodes"];
    }
    
    if (cities == nil && zipCodes == nil) {
        [output appendString:@"Error getting cities and zip codes."];
        return output;
    }
    
    for (USCity *city in cities) {
        [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
        [output appendString:[@"\nState: " stringByAppendingString:city.state]];
        [output appendString:[@"\nMailable City: " stringByAppendingString:city.objcMailableCity ? @"YES" : @"NO"]];
        [output appendString:@"\n"];
    }
    
    for (USZipCode *zip in zipCodes) {
        [output appendString:[@"\nZIP Code: " stringByAppendingString:zip.zipCode]];
        [output appendString:@"\n"];
    }
    
    return output;
}

@end
