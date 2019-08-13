#import "ObjCZIPExample.h"

@interface ObjCZIPExample ()

@end

@implementation ObjCZIPExample

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"lines-map"] drawInRect:self.view.bounds];
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
    
}

- (IBAction)lookup:(UIButton *)sender {
    _results.text = [self run];
    [self.view endEditing:true];
}

- (NSString*)run {
    USZipCodeClient *client = [[ClientBuilder alloc] initWithId:@"KEY" hostname:@"hostname"].buildUsZIPCodeApiClient;
    NSError* error = nil;
    
    // Documentation for input fields can be found at:
    // https://smartystreets.com/docs/cloud/us-zipcode-api
    
    USZipCodeLookup *lookup = [[USZipCodeLookup alloc] initWithCity:_city.text state:_state.text zipcode:_zipCode.text inputId:@""];
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    
    USZipCodeResult* result = lookup.result;
    NSArray<USZipCode*>* zipCodes = result.zipCodes;
    NSArray<USCity*>* cities = result.cities;
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (success) {
        [output appendString:@"Successfully retrieved ZipCodes"];
    }
    
    if (cities == nil && zipCodes == nil) {
        [output appendString:@"Error getting cities and zip codes."];
        return output;
    }
    
    for (USCity *city in cities) {
        [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
        [output appendString:[@"\nState: " stringByAppendingString:city.state]];
        [output appendString:[@"\nMailable City: " stringByAppendingString:city.objcMailableCity ? @"YES" : @"NO"]];
        [output appendString:@"\n"];
    }
    
    for (USZipCode *zip in zipCodes) {
        [output appendString:[@"\nZIP Code: " stringByAppendingString:zip.zipCode]];
        [output appendString:@"\n"];
    }
    
    return output;
}
    
- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
