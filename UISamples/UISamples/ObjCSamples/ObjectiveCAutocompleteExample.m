#import "ObjectiveCAutocompleteExample.h"

@interface ObjectiveCAutocompleteExample ()

@end

@implementation ObjectiveCAutocompleteExample

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"lines-map"] drawInRect:self.view.bounds];
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
}

- (IBAction)addressChanged:(UITextField *)sender {
    _result.text = [self run];
}

- (NSString*)run {
    USAutocompleteClient* client = [[ClientBuilder alloc] initWithId:@"KEY" hostname:@"hostname"].buildUSAutocompleteApiClient;
    
    //            Documentation for input fields can be found at:
    //            https://smartystreets.com/docs/us-autocomplete-api#http-request-input-fields
    
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
