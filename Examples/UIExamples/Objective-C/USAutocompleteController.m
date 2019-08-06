#import "USAutocompleteController.h"
#import "SmartyStreetsiOSSDK-Swift.h"

@interface USAutocompleteController ()

@end

@implementation USAutocompleteController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)addressChanged:(UITextField *)sender {
    _result.text = [self run];
}

- (NSString*)run {
    USAutocompleteClient* client = [[SSClientBuilder alloc] initWithId:@"KEY" hostname:@"hostname"].buildUSAutocompleteApiClient;
//    NSString* authId = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_ID"];
//    NSString* authToken = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_TOKEN"];
//    USAutocompleteClient* client = [[SSClientBuilder alloc] initWithAuthId:authId authToken:authToken].buildUSAutocompleteApiClient;
    
    USAutocompleteLookup* lookup = [[[USAutocompleteLookup alloc] init] withPrefixWithPrefix:_prefix.text];
    [lookup addCityFilterWithCity:_city.text];
    [lookup addStateFilterWithState:_state.text];
    NSError* error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    
    NSMutableString* output = [[NSMutableString alloc] init];
    NSArray<USAutocompleteSuggestion*>* suggestions = lookup.result.suggestions;
    
    for (USAutocompleteSuggestion* suggestion in suggestions) {
        [output appendString:[suggestion.text stringByAppendingString:@"\n"]];
    }
    return output;
}

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
