#import "SSInternationalStreetExample.h"

@implementation SSInternationalStreetExample

- (NSString*)run {
    SSInternationalStreetClient *client = [[SSClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].buildInternationalStreetApiClient;
    
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] initWithFreeform:@"Rua Padre Antonio D'Angelo 121 Casa Verde, Sao Paulo" withCountry:@"Brazil"];
    [lookup enableGeocode:true];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    SSInternationalStreetCandidate *firstCandidate = lookup.result[0];
    NSMutableString *output = [NSMutableString new];
    
    [output appendString:[@"Address is " stringByAppendingString:firstCandidate.analysis.verificationStatus]];
    [output appendString:[@"\nAddress precision: " stringByAppendingString:firstCandidate.analysis.addressPrecision]];
    [output appendString:@"\n"];
    [output appendString:[@"\nFirst Line: " stringByAppendingString:firstCandidate.address1]];
    [output appendString:[@"\nSecond Line: " stringByAppendingString:firstCandidate.address2]];
    [output appendString:[@"\nThird Line: " stringByAppendingString:firstCandidate.address3]];
    [output appendString:[@"\nFourth Line: " stringByAppendingString:firstCandidate.address4]];
    
    SSInternationalStreetMetadata *metadata = firstCandidate.metadata;
    NSNumber *latitude = [NSNumber numberWithDouble:metadata.latitude];
    NSNumber *longitute = [NSNumber numberWithDouble:metadata.longitude];
    [output appendString:[@"\nLatitude: " stringByAppendingString:[latitude stringValue]]];
    [output appendString:[@"\nLongitude: " stringByAppendingString:[longitute stringValue]]];
    
    return output;
}

@end
