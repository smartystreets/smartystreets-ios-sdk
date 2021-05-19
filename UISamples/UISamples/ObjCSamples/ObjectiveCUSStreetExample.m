#import "ObjectiveCUSStreetExample.h"

@interface ObjectiveCUSStreetExample ()

@end

@implementation ObjectiveCUSStreetExample

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"lines-map"] drawInRect:self.view.bounds];
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
}

- (IBAction)search:(UIButton *)sender {
    [self.view endEditing:true];
    _result.text = [self run];
}

- (NSString *)run {
    //            The appropriate license values to be used for your subscriptions can be found on the Subscriptions page of the account dashboard.
    //            https://www.smartystreets.com/docs/cloud/licensing
    USStreetClient* client = [[ClientBuilder alloc] initWithId:@"KEY" hostname:@"hostname"].withLicenses(["us-rooftop-geocoding-cloud"]).buildUsStreetApiClient;
    NSError* error = nil;
    
    USStreetLookup* lookup = [[USStreetLookup alloc] init];
    
    // Documentation for input fields can be found at:
    // https://smartystreets.com/docs/cloud/us-street-api
    
    if ([_freeform.text length] > 0) {
        lookup = [[USStreetLookup alloc] initWithFreeformAddress:_freeform.text];
    } else {
        lookup.street = _street.text;
        lookup.city = _city.text;
        lookup.state = _state.text;
        lookup.matchStrategy = @"invalid";
    }
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return error.localizedDescription;
    }
    
    NSArray<USStreetCandidate*>* results = lookup.result;
    NSMutableString* output = [[NSMutableString alloc] init];
    
    if (results.count == 0) {
        [output appendString:@"\nAddress is invalid\n"];
        return output;
    }
    
    USStreetCandidate* candidate = [results objectAtIndex:0];
    
    [output appendString:[NSString stringWithFormat:@"\nAddress is valid\n"]];
    
    USStreetComponents const *components = candidate.components;
    USStreetMetadata const *metadata = candidate.metadata;
    
    [output appendString:[@"\nDelivery line 1:  " stringByAppendingString:candidate.deliveryLine1]];
    [output appendString:[@"\nLast line:        " stringByAppendingString:candidate.lastline]];
    [output appendString:[@"\nZIP Code:         " stringByAppendingString:components.zipCode]];
    [output appendString:[@"-" stringByAppendingString:components.plus4Code]];
    [output appendString:[@"\nCounty:           " stringByAppendingString:metadata.countyName]];
    [output appendString:[@"\nLatitude:         " stringByAppendingString:[metadata.objcLatitude stringValue]]];
    [output appendString:[@"\nLongitude:        " stringByAppendingString:[metadata.objcLongitude stringValue]]];
    
    [output appendString:@"\n***********************************\n"];
    
    NSLog(@"Output = %@", output);
    return output;
}

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
