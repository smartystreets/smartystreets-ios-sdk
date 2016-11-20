#import "SSZipCodeSingleLookupExample.h"

@implementation SSZipCodeSingleLookupExample

- (NSString*)run {
    id<SSCredentials> mobile = [[SSSharedCredentials alloc] initWithId:kSSSmartyWebsiteKey hostname:kSSHost];
    SSZipCodeClient *client = [[SSZipCodeClientBuilder alloc] initWithSigner:mobile].build;
//    SSZipCodeClient *client = [[SSZipCodeClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].build;
    
    SSZipCodeLookup *lookup = [[SSZipCodeLookup alloc] init];
    lookup.city = @"Mountain View";
    lookup.state = @"California";
    
    NSError *error = nil;
    [client sendLookup:lookup error:&error];
    
    if (error != nil) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return @"Error sending request";
    }
    
    SSResult *result = lookup.result;
    NSArray<SSZipCode*> *zipCodes = result.zipCodes;
    NSArray<SSCity*> *cities = result.cities;
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (cities == nil && zipCodes == nil) {
        [output appendString:@"Error getting cities and zip codes."];
        return output;
    }
    
    for (SSCity *city in cities) {
        [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
        [output appendString:[@"\nState: " stringByAppendingString:city.state]];
        [output appendString:[@"\nMailable City: " stringByAppendingString:city.mailableCity ? @"YES" : @"NO"]];
        [output appendString:@"\n"];
    }
    
    for (SSZipCode *zip in zipCodes) {
        [output appendString:[@"\nZIP Code: " stringByAppendingString:zip.zipCode]];
        NSNumber *latitude = [NSNumber numberWithDouble:zip.latitude];
        NSNumber *longitute = [NSNumber numberWithDouble:zip.longitude];
        [output appendString:[@"\nLatitude: " stringByAppendingString:[latitude stringValue]]];
        [output appendString:[@"\nLongitude: " stringByAppendingString:[longitute stringValue]]];
        [output appendString:@"\n"];
    }
    
    return output;
}

@end
