#import "ObjectiveCInternationalExample.h"

@interface ObjectiveCInternationalExample ()

@end

@implementation ObjectiveCInternationalExample

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

- (NSString*)run {
    InternationalStreetClient* client = [[ClientBuilder alloc] initWithId:@"KEY" hostname:@"hostname"].buildInternationalStreetApiClient;
    
    // Documentation for input fields can be found at:
    // https://smartystreets.com/docs/cloud/international-street-api#http-input-fields
    
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
