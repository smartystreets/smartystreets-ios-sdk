#import "USStreetMultipleExample.h"

@interface USStreetMultipleExample ()

@end

@implementation USStreetMultipleExample

- (NSString*)run {
    //            The appropriate license values to be used for your subscriptions
    //            can be found on the Subscriptions page of the account dashboard.
    //            https://www.smartystreets.com/docs/cloud/licensing
    USStreetClient *client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].withLicenses(["us-rooftop-geocoding-cloud"]).buildUsStreetApiClient;
    NSError *error = nil;
    
    //        Documentation for input fields can be found at:
    //        https://smartystreets.com/docs/us-street-api#input-fields
    USStreetLookup *address1 = [[USStreetLookup alloc] init];
    address1.inputId = @"24601";
    address1.addressee = @"John Doe";
    address1.street = @"1600 amphitheatre parkway";
    address1.street2 = @"closet under the stairs";
    address1.secondary = @"APT 2";
    address1.urbanization = @""; // Only applies to Puerto Rico addresses
    address1.lastline = @"Mountain view, california";
    address1.matchStrategy = @"invalid"; // "invalid" is the most permissive match,
                                         // this will always return at least one result even if the address is invalid.
                                         // Refer to the documentiation for additional Match Strategy options.
    
    USStreetLookup *address2 = [[USStreetLookup alloc] initWithFreeformAddress:@"1 Rosedale, Baltimore, Maryland"];
    
    USStreetLookup *address3 = [[USStreetLookup alloc] initWithFreeformAddress: @"123 Bogus Street, Pretend Lake, Oklahoma"];
    
    USStreetLookup *address4 = [[USStreetLookup alloc] init];
    address4.inputId = @"8675309";
    address4.street = @"1 Infinite Loop";
    address4.zipCode = @"95014";
    
    USStreetBatch *batch = [[USStreetBatch alloc] init];
    
    _Bool success = [batch addWithNewAddress:address1 error:&error];
    success = [batch addWithNewAddress:address2 error:&error];
    success = [batch addWithNewAddress:address3 error:&error];
    success = [batch addWithNewAddress:address4 error:&error];
    
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
        NSArray<USStreetCandidate*> *candidates = [[lookups objectAtIndex:i] result];
        
        if (candidates.count == 0) {
            [output appendString:[NSString stringWithFormat:@"\nAddress %i is invalid\n", i]];
            continue;
        }
        
        [output appendString:[NSString stringWithFormat:@"\nAddress %i has at least one candidate.\n If the match parameter is set to STRICT, the address is valid.\n Otherwise, chec, the Analysis output fields to see if the address is valid.", i]];
        
        for (USStreetCandidate *candidate in candidates) {
            USStreetComponents const *components = candidate.components;
            USStreetMetadata const *metadata = candidate.metadata;
            
            [output appendString:[NSString stringWithFormat:@"\n\nCandidate %@ :", candidate.objcCandidateIndex]];
            [output appendString:[@"\nDelivery line 1:  " stringByAppendingString:candidate.deliveryLine1]];
            [output appendString:[@"\nLast line:        " stringByAppendingString:candidate.lastline]];
            [output appendString:[@"\nZIP Code:         " stringByAppendingString:components.zipCode]];
            [output appendString:[@"-" stringByAppendingString:components.plus4Code]];
            [output appendString:[@"\nCounty:           " stringByAppendingString:metadata.countyName]];
            [output appendString:[@"\nLatitude:         " stringByAppendingString:[metadata.objcLatitude stringValue]]];
            [output appendString:[@"\nLongitude:        " stringByAppendingString:[metadata.objcLongitude stringValue]]];
        }
        
        [output appendString:@"\n***********************************\n"];
    }
    
    return output;
}


@end
