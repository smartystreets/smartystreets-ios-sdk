#import "InternationalStreetSingle.h"
#import "smartystreets_iOS_sdk-Swift.h"

@interface InternationalStreetSingle ()

@end

@implementation InternationalStreetSingle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)search:(UIButton *)sender {
    _result.text = [self run];
}

- (NSString*)run {
    InternationalStreetClient* client = [[SSClientBuilder alloc] initWithId:@"KEY" hostname:@"hostname"].buildInternationalStreetApiClient;
//    NSString* authId = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_ID"];
//    NSString* authToken = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_TOKEN"];
//    InternationalStreetClient* client = [[SSClientBuilder alloc] initWithAuthId:authId authToken:authToken].buildInternationalStreetApiClient;
    
    InternationalStreetLookup* lookup = [[InternationalStreetLookup alloc] initWithFreeform:_freeform.text country:_country.text inputId:nil];
    [lookup enableGeocodeWithGeocode:true];
    NSError* error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    
    InternationalStreetCandidate* firstCandidate = lookup.result[0];
    NSMutableString *output = [NSMutableString new];
    
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

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
