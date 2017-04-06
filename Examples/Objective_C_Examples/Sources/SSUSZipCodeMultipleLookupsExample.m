#import "SSUSZipCodeMultipleLookupsExample.h"

@implementation SSUSZipCodeMultipleLookupsExample

- (NSString*)run {
    SSUSZipCodeClient *client = [[SSClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].buildUsZIPCodeApiClient;
    
    SSBatch *batch = [[SSBatch alloc] init];
    
    SSUSZipCodeLookup *lookup1 = [[SSUSZipCodeLookup alloc] init];
    lookup1.zipcode = @"12345"; // A Lookup may have a ZIP Code, city and state, or city, state, and ZIP Code
    
    SSUSZipCodeLookup *lookup2 = [[SSUSZipCodeLookup alloc] init];
    lookup2.city = @"Phoenix";
    lookup2.state = @"Arizona";
    
    SSUSZipCodeLookup *lookup3 = [[SSUSZipCodeLookup alloc] initWithCity:@"cupertino" state:@"CA" zipcode:@"95014"];
    
    NSError *error = nil;
    [batch add:lookup1 error:&error];
    [batch add:lookup2 error:&error];
    [batch add:lookup3 error:&error];
    
    if (error != nil) {
        if ([error.domain isEqualToString:@"SSSmartyErrorDomain"] && error.code == BatchFullError) {
            NSLog(@"Description: %@", [error localizedDescription]);
            return @"Error. The batch is already full.";
        }
    }
    
    [client sendBatch:batch error:&error];
    
    if (error != nil) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return @"Error sending request";
    }
    
    NSArray *lookups = batch.allLookups;
    NSMutableString *output = [[NSMutableString alloc] init];
    
    for (int i = 0; i < batch.count; i++) {
        SSUSZipCodeResult *result = [[lookups objectAtIndex:i] result];
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
        
        NSArray<SSUSCity*> *cities = result.cities;
        [output appendString:[@(cities.count) stringValue]];
        [output appendString:@" City and States match(es):"];
        
        for (SSUSCity *city in cities) {
            [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
            [output appendString:[@"\nState: " stringByAppendingString:city.state]];
            [output appendString:[@"\nMailable City: " stringByAppendingString:city.mailableCity ? @"YES" : @"NO"]];
            [output appendString:@"\n"];
        }

        [output appendString:@"\n"];
        NSArray<SSUSZipCode*> *zipCodes = result.zipCodes;
        [output appendString:[@(zipCodes.count) stringValue]];
        [output appendString:@" ZIP Code match(es):"];
        
        for (SSUSZipCode *zip in zipCodes) {
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
