#import "SSZipCodeMultipleLookupsExample.h"
#import </Users/oshion/Library/Developer/Xcode/DerivedData/Smartystreets_iOS_SDK-hgqhnhhppaibdnfgaptgxhhngupi/Build/Products/Debug-iphonesimulator/Smartystreets_iOS_SDK.framework/Headers/SSZipCodeClientBuilder.h> //TODO: get imports working correctly
//#import </Users/oshion/Library/Developer/Xcode/DerivedData/Smartystreets_iOS_SDK-hgqhnhhppaibdnfgaptgxhhngupi/Build/Products/Debug-iphonesimulator/Smartystreets_iOS_SDK.framework/Headers/SSSharedCredentials.h>
#import "SSMyCredentials.h"

@implementation SSZipCodeMultipleLookupsExample

- (NSString*)runCode {
    //    id<SSCredentials> mobile = [[SSSharedCredentials alloc] initWithId:kSSSmartyWebsiteKey hostname:kSSHost];
    //    SSStreetClient *client = [[SSStreetClientBuilder alloc] initWithSigner:mobile].build;
    SSZipCodeClient *client = [[SSZipCodeClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].build;
    
    SSZipCodeBatch *batch = [[SSZipCodeBatch alloc] init];
    
    SSZipCodeLookup *lookup1 = [[SSZipCodeLookup alloc] init];
    lookup1.zipcode = @"12345"; // A Lookup may have a ZIP Code, city and state, or city, state, and ZIP Code
    
    SSZipCodeLookup *lookup2 = [[SSZipCodeLookup alloc] init];
    lookup2.city = @"Phoenix";
    lookup2.state = @"Arizona";
    
    SSZipCodeLookup *lookup3 = [[SSZipCodeLookup alloc] initWithCity:@"cupertino" state:@"CA" zipcode:@"95014"];
    
    NSError *error = nil;
    [batch add:lookup1 error:&error];
    [batch add:lookup2 error:&error];
    [batch add:lookup3 error:&error];
    [client sendBatch:batch error:&error];
    
    if (error != nil) {
        //TODO: handle error
    }
    
    NSArray *lookups = batch.allLookups;
    NSMutableString *output = [[NSMutableString alloc] init];
    
    for (int i = 0; i < batch.count; i++) {
        SSResult *result = [[lookups objectAtIndex:i] result];
        [output appendString:[@"\nLookup " stringByAppendingString:[@(i) stringValue]]];
        [output appendString:@"\n\n"];
        
        if (result.status != nil) {
            [output appendString:[@"Status: " stringByAppendingString:result.status]];
            [output appendString:[@"\nReason: " stringByAppendingString:result.reason]];
            [output appendString:@"\n"];
            continue;
        }
        
        if (result.cities == nil && result.zipCodes == nil) {
            [output appendString:@"Error getting cities and zip codes.\n\n"];
            [output appendString:@"***************\n\n"];
            continue;
        }
        
        NSArray<SSCity*> *cities = result.cities;
        [output appendString:[@(cities.count) stringValue]];
        [output appendString:@" City and States match(es):"];
        
        for (SSCity *city in cities) {
            [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
            [output appendString:[@"\nState: " stringByAppendingString:city.state]];
            [output appendString:[@"\nMailable City: " stringByAppendingString:city.mailableCity ? @"YES" : @"NO"]];
            [output appendString:@"\n"];
        }

        [output appendString:@"\n"];
        NSArray<SSZipCode*> *zipCodes = result.zipCodes;
        [output appendString:[@(zipCodes.count) stringValue]];
        [output appendString:@" ZIP Code match(es):"];
        
        for (SSZipCode *zip in zipCodes) {
            [output appendString:[@"\nZIP Code: " stringByAppendingString:zip.zipCode]];
            [output appendString:[@"\nCounty: " stringByAppendingString:zip.countyName]];
            NSNumber *latitude = [NSNumber numberWithDouble:zip.latitude];
            NSNumber *longitute = [NSNumber numberWithDouble:zip.longitude];
            [output appendString:[@"\nLatitude: " stringByAppendingString:[latitude stringValue]]];
            [output appendString:[@"\nLongitude: " stringByAppendingString:[longitute stringValue]]];
            [output appendString:@"\n"];
        }
        [output appendString:@"***********************************\n"];
    }
    
    NSLog(@"Output = %@", output);
    return output;
}

@end
