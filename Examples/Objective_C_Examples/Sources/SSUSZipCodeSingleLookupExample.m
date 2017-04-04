#import "SSUSZipCodeSingleLookupExample.h"

@implementation SSUSZipCodeSingleLookupExample

- (NSString*)run {
    id<SSCredentials> mobile = [[SSSharedCredentials alloc] initWithId:kSSSmartyWebsiteKey hostname:kSSHost];
    SSUSZipCodeClient *client = [[SSClientBuilder alloc] initWithSigner:mobile].buildUsZIPCodeApiClient;
//    SSUSZipCodeClient *client = [[SSClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].buildUsZIPCodeApiClient;
    
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
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
    
    SSUSZipCodeResult *result = lookup.result;
    NSArray<SSUSZipCode*> *zipCodes = result.zipCodes;
    NSArray<SSUSCity*> *cities = result.cities;
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (cities == nil && zipCodes == nil) {
        [output appendString:@"Error getting cities and zip codes."];
        return output;
    }
    
    for (SSUSCity *city in cities) {
        [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
        [output appendString:[@"\nState: " stringByAppendingString:city.state]];
        [output appendString:[@"\nMailable City: " stringByAppendingString:city.mailableCity ? @"YES" : @"NO"]];
        [output appendString:@"\n"];
    }
    
    for (SSUSZipCode *zip in zipCodes) {
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
