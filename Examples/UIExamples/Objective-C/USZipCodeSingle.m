#import "USZipCodeSingle.h"
#import "smartystreets_iOS_sdk-Swift.h"

@interface USZipCodeSingle ()

@end

@implementation USZipCodeSingle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)lookup:(UIButton *)sender {
    _result.text = [self run];
}

- (NSString*)run {
    SSUSZipCodeClient *client = [[SSClientBuilder alloc] initWithId:@"key" hostname:@"hostname"].buildUsZIPCodeApiClient;
//    NSString* authId = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_ID"];
//    NSString* authToken = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_TOKEN"];
//    SSUSZipCodeClient *client = [[SSClientBuilder alloc] initWithAuthId:authId authToken:authToken].buildUsZIPCodeApiClient;
    
    
    USZipCodeLookup *lookup = [[USZipCodeLookup alloc] initWithCity:_city.text state:_state.text zipcode:_zipCode.text inputId:@""];
    
    NSError* error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (error != nil) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return @"Error sending request";
    }
    
    USZipCodeResult* result = lookup.result;
    NSArray<SSUSZipCode*>* zipCodes = result.zipCodes;
    NSArray<SSUSCity*>* cities = result.cities;
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (success) {
        [output appendString:@"Successfully retrieved ZipCodes"];
    }
    
    if (cities == nil && zipCodes == nil) {
        [output appendString:@"Error getting cities and zip codes."];
        return output;
    }
    
    for (SSUSCity *city in cities) {
        [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
        [output appendString:[@"\nState: " stringByAppendingString:city.state]];
        [output appendString:[@"\nMailable City: " stringByAppendingString:city.objcMailableCity ? @"YES" : @"NO"]];
        [output appendString:@"\n"];
    }
    
    for (SSUSZipCode *zip in zipCodes) {
        [output appendString:[@"\nZIP Code: " stringByAppendingString:zip.zipCode]];
        [output appendString:@"\n"];
    }
    
    return output;
}

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
