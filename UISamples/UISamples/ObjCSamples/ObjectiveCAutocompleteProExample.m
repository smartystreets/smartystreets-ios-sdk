#import "ObjectiveCAutocompleteProExample.h"

@interface ObjectiveCAutocompleteProExample ()

@end

@implementation ObjectiveCAutocompleteProExample

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
    USAutocompleteProClient* client = [[ClientBuilder alloc] initWithId:@"Key" hostname:@"Hostname"].buildUSAutocompleteProApiClient;
    
    //            Documentation for input fields can be found at:
    //            https://smartystreets.com/docs/us-autocomplete-api#http-request-input-fields
    
    USAutocompleteProLookup* lookup = [[[USAutocompleteProLookup alloc] init] withSearchWithSearch:_search.text];
    [lookup addCityFilterWithCity:_cityFilter.text];
    [lookup addStateFilterWithState:_stateFilter.text];
    NSError* error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    
    NSMutableString* output = [[NSMutableString alloc] init];
    NSArray<USAutocompleteProSuggestion*>* suggestions = lookup.result.suggestions;
    
    for (USAutocompleteProSuggestion* suggestion in suggestions) {
        [output appendString:[suggestion.streetLine stringByAppendingString:@" "]];
        [output appendString:[suggestion.secondary stringByAppendingString:@" "]];
        [output appendString:[suggestion.city stringByAppendingString:@", "]];
        [output appendString:[suggestion.state stringByAppendingString:@" "]];
        [output appendString:[suggestion.zipcode stringByAppendingString:@"\n"]];
    }
    return output;
}

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
