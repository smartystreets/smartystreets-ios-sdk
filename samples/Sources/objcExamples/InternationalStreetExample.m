#import "InternationalStreetExample.h"

@interface InternationalStreetExample ()

@end

@implementation InternationalStreetExample

- (NSString*)run {
    InternationalStreetClient* client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].buildInternationalStreetApiClient;
    
    // Documentation for input fields can be found at:
    // https://smartystreets.com/docs/cloud/international-street-api#http-input-fields
    InternationalStreetLookup *lookup = [[InternationalStreetLookup alloc] init];
    lookup.inputId = @"ID-8675309";
    lookup.organization = @"John Doe";
    lookup.address1 = @"Rua Padre Antonio D'Angelo 121";
    lookup.address2 = @"Casa Verde";
    lookup.locality = @"Sao Paulo";
    lookup.administrativeArea = @"SP";
    lookup.country = @"Brazil";
    lookup.postalCode = @"02516-050";
    [lookup enableGeocodeWithGeocode:true];
    NSError *error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (!success) {
        [output appendFormat:@"Domain: %@\n", error.domain];
        [output appendFormat:@"Error Code: %ld\n", (long)error.code];
        [output appendFormat:@"Description: %@\n", [error localizedDescription]];
        return output;
    }
    
    InternationalStreetCandidate* firstCandidate = lookup.result[0];
    
    [output appendString:[@"Address is " stringByAppendingString:firstCandidate.analysis.verificationStatus]];
    [output appendString:[@"\nAddress precision: " stringByAppendingString:firstCandidate.analysis.addressPrecision]];
    [output appendString:@"\n"];
    [output appendString:[@"\nFirst Line: " stringByAppendingString:firstCandidate.address1]];
    [output appendString:[@"\nSecond Line: " stringByAppendingString:firstCandidate.address2]];
    [output appendString:[@"\nThird Line: " stringByAppendingString:firstCandidate.address3]];
    [output appendString:[@"\nFourth Line: " stringByAppendingString:firstCandidate.address4]];
    
    InternationalStreetMetadata *metadata = firstCandidate.metadata;
    [output appendString:[@"\nLatitude: " stringByAppendingString:[metadata.objcLatitude stringValue]]];
    [output appendString:[@"\nLongitude: " stringByAppendingString:[metadata.objcLongitude stringValue]]];
    
    return output;
}

@end
