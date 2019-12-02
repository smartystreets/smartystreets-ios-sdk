#import "USAutocompleteProExample.h"

@interface USAutocompleteProExample ()

@end

@implementation USAutocompleteProExample

- (NSString*)run {
    USAutocompleteProClient* client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].buildUSAutocompleteProApiClient;
    
    //            Documentation for input fields can be found at:
    //            https://smartystreets.com/docs/cloud/us-autocomplete-api#pro-http-request-input-fields
    USAutocompleteProLookup *lookup = [[[USAutocompleteProLookup alloc] init] withSearchWithSearch:@"4770 Lincoln Ave O"];
    [lookup addCityFilterWithCity:@"Dorchester"];
    [lookup addCityFilterWithCity:@"Boston"];
    [lookup addStateFilterWithState:@"MA"];
    [lookup addPreferCityWithCity:@"Dorchester"];
    [lookup addPreferStateWithState:@"MA"];
    [lookup setPreferGeolocation:[[GeolocateType alloc] initWithName:@"null"]];
    NSError *error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (!success) {
        [output appendFormat:@"Domain: %@\n", error.domain];
        [output appendFormat:@"Error Code: %ld\n", (long)error.code];
        [output appendFormat:@"Description: %@\n", [error localizedDescription]];
        return output;
    }
    
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

@end
