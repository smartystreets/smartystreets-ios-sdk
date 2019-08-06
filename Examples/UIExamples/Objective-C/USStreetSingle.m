#import "USStreetSingle.h"
#import "smartystreets_iOS_sdk-Swift.h"

@interface USStreetSingle ()

@end

@implementation USStreetSingle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)Search:(UIButton *)sender {
    _result.text = [self run];
}

- (NSString*)run {
    USStreetClient* client = [[SSClientBuilder alloc] initWithId:@"KEY" hostname:@"hostname"].buildUsStreetApiClient;
//    NSString* authId = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_ID"];
//    NSString* authToken = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_TOKEN"];
//    USStreetClient* client = [[SSClientBuilder alloc] initWithAuthId:authId authToken:authToken].buildUsStreetApiClient;
    
    USStreetLookup* lookup = [[USStreetLookup alloc] init];
    if ([_freeform.text length] > 0) {
        lookup = [[USStreetLookup alloc] initWithFreeformAddress:_freeform.text];
    } else {
        lookup.street = _street.text;
        lookup.city = _city.text;
        lookup.state = _state.text;
        lookup.matchStrategy = @"invalid";
    }
    
    NSError* error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    
    NSArray<USStreetCandidate*> *results = lookup.result;
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (results.count == 0) {
        [output appendString:@"Error. Address is not valid"];
        return output;
    }
    
    USStreetCandidate* candidate = [results objectAtIndex:0];
    
    [output appendString:@"Address is valid. (There is at least one candidate)\n\n"];
    [output appendString:[@"\nZIP Code: " stringByAppendingString:candidate.components.zipCode]];
    [output appendString:[@"\nCounty: " stringByAppendingString:candidate.metadata.countyName]];
    [output appendString:[@"\nLatitude: " stringByAppendingString:[candidate.metadata.objcLatitude stringValue]]];
    [output appendString:[@"\nLongiude: " stringByAppendingString:[candidate.metadata.objcLongitude stringValue]]];
    
    return output;
}

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
