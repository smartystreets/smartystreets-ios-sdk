#import "USZipCodeMultipleExample.h"

@interface USZipCodeMultipleExample ()

@end

@implementation USZipCodeMultipleExample

-(NSString*)run {
    USZipCodeClient* client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].buildUsZIPCodeApiClient;
    NSError *error = nil;
    
    //        Documentation for input fields can be found at:
    //        https://smartystreet.com/docs/us-zipcode-api#input-fields
    USZipCodeLookup *lookup1 = [[USZipCodeLookup alloc] init];
    lookup1.inputId = @"011889998819991197253"; // Optional ID from your system
    lookup1.zipcode = @"12345"; // A Lookup may have a ZIP Code, city and state, or city, state, and ZIP Code
    
    USZipCodeLookup *lookup2 = [[USZipCodeLookup alloc] init];
    lookup2.city = @"Phoenix";
    lookup2.state = @"Arizona";
    
    USZipCodeLookup *lookup3 = [[USZipCodeLookup alloc] initWithCity:@"cupertino" state:@"CA" zipcode:@"95014" inputId:nil];
    
    USZipCodeBatch *batch = [[USZipCodeBatch alloc] init];
    _Bool success = [batch addWithNewAddress:lookup1 error:&error];
    success = [batch addWithNewAddress:lookup2 error:&error];
    success = [batch addWithNewAddress:lookup3 error:&error];
    
    success = [client sendBatchWithBatch:batch error:&error];
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (!success) {
        [output appendFormat:@"Domain: %@\n", error.domain];
        [output appendFormat:@"Error Code: %ld\n", (long)error.code];
        [output appendFormat:@"Description: %@\n", [error localizedDescription]];
        return output;
    }
    
    NSArray *lookups = batch.allLookups;
    
    for (int i = 0; i < batch.count; i++) {
        USZipCodeLookup* lookup = [lookups objectAtIndex:i];
        USZipCodeResult* result = lookup.result;
        [output appendString:[@"\nLookup " stringByAppendingString:[@(i + 1) stringValue]]];
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
        
        NSArray<USCity*> *cities = result.cities;
        [output appendString:[@(cities.count) stringValue]];
        [output appendString:@" City and States match(es):"];
        
        for (USCity *city in cities) {
            [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
            [output appendString:[@"\nState: " stringByAppendingString:city.state]];
            [output appendString:[@"\nMailable City: " stringByAppendingString:city.objcMailableCity ? @"YES" : @"NO"]];
            [output appendString:@"\n"];
        }
        
        [output appendString:@"\n"];
        NSArray<USZipCode*> *zipCodes = result.zipCodes;
        [output appendString:[@(zipCodes.count) stringValue]];
        [output appendString:@" ZIP Code match(es):"];
        
        for (USZipCode *zip in zipCodes) {
            [output appendString:[@"\nZIP Code: " stringByAppendingString:zip.zipCode]];
            [output appendString:[@"\nCounty: " stringByAppendingString:zip.countyName]];
            [output appendString:[@"\nLatitude: " stringByAppendingString:[zip.objcLatitude stringValue]]];
            [output appendString:[@"\nLongitude: " stringByAppendingString:[zip.objcLongitude stringValue]]];
            [output appendString:@"\n"];
        }
        [output appendString:@"***********************************\n"];
    }
    
    return output;
}

@end
