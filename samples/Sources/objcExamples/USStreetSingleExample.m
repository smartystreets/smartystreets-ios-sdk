#import "USStreetSingleExample.h"

@interface USStreetSingleExample ()

@end

@implementation USStreetSingleExample

- (NSString*) run {
    NSMutableString* output = [[NSMutableString alloc] init];
    
    USStreetClient* client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].buildUsStreetApiClient;
    
    //        Documentation for input fields can be found at:
    //        https://smartystreets.com/docs/us-street-api#input-fields
    USStreetLookup* lookup = [[USStreetLookup alloc] init];
    lookup.inputId = @"24601";
    lookup.addressee = @"John Doe";
    lookup.street = @"1600 Amphitheatre Pkwy";
    lookup.street2 = @"closet under the stairs";
    lookup.secondary = @"APT 2";
    lookup.urbanization = @""; // Only applies to Puerto Rico addresses
    lookup.city = @"Mountain View";
    lookup.state = @"CA";
    lookup.zipCode = @"94043";
    lookup.matchStrategy = @"invalid";
    
    NSError* error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (!success) {
        [output appendFormat:@"Domain: %@\n", error.domain];
        [output appendFormat:@"Error Code: %ld\n", (long)error.code];
        [output appendFormat:@"Description: %@\n", [error localizedDescription]];
        return output;
    }
    
    NSArray<USStreetCandidate*> *results = lookup.result;
    
    if (results.count == 0) {
        [output appendString:@"Address is not valid"];
        return output;
    }
    
    USStreetCandidate* candidate = [results objectAtIndex:0];
    
    [output appendString:@"Address is valid. (There is at least one candidate)\n\n"];
    [output appendString:[@"\nZIP Code: " stringByAppendingString:candidate.components.zipCode]];
    [output appendString:[@"\nCounty: " stringByAppendingString:candidate.metadata.countyName]];
    [output appendString:[@"\nLatitude: " stringByAppendingString:[candidate.metadata.objcLatitude stringValue]]];
    [output appendString:[@"\nLongiude: " stringByAppendingString:[candidate.metadata.objcLongitude stringValue]]];
    
    return output;
    // return @"Hello USStreetSingleExample!";
}

@end
