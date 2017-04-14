#import "SSInternationalStreetExample.h"

@implementation SSInternationalStreetExample

- (NSString*)run {
    SSInternationalStreetClient *client = [[SSClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].buildInternationalStreetApiClient;
    
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] initWithFreeform:@"Rua Padre Antonio D'Angelo 121 Casa Verde, Sao Paulo" withCountry:@"Brazil"];
    [lookup enableGeocode:true];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    SSInternationalStreetCandidate = lookup.result[0];
    NSMutableString *output = [NSMutableString new];
    
    output += @"Address is " + firstCandidate.analysis.verificationStatus;
    output += @"\nAddress precision: " + firstCandidate.analysis.addressPrecision + @"\n";
    
    output += @"\nFirst Line: " + firstCandidate.address1;
    output += @"\nSecond Line: " + firstCandidate.address2;
    output += @"\nThird Line: " + firstCandidate.address3;
    output += @"\nFourth Line: " + firstCandidate.address4;
    
    SSInternationalStreetMetadata *metadata = firstCandidate.metadata;
    NSNumber *latitude = [NSNumber numberWithDouble:metadata.latitude];
    NSNumber *longitute = [NSNumber numberWithDouble:metadata.longitude];
    [output appendString:[@"\nLatitude: " stringByAppendingString:[latitude stringValue]]];
    [output appendString:[@"\nLongitude: " stringByAppendingString:[longitute stringValue]]];
    
    return output;
}

@end
