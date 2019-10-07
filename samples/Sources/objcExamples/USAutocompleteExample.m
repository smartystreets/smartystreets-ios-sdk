#import "USAutocompleteExample.h"

@interface USAutocompleteExample ()

@end

@implementation USAutocompleteExample

- (NSString*)run {
    USAutocompleteClient* client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].buildUSAutocompleteApiClient;
    
    //            Documentation for input fields can be found at:
    //            https://smartystreets.com/docs/us-autocomplete-api#http-request-input-fields
    USAutocompleteLookup *lookup = [[[USAutocompleteLookup alloc] init] withPrefixWithPrefix:@"4770 Lincoln Ave O"];
    [lookup addCityFilterWithCity:@"Ogden"];
    [lookup addStateFilterWithState:@"IL"];
    [lookup addPreferWithCityORstate:@"Fallon, IL"];
    [lookup setGeolocateType:[[GeolocateType alloc] initWithName:@"null"]];
    NSError *error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (!success) {
        [output appendFormat:@"Domain: %@\n", error.domain];
        [output appendFormat:@"Error Code: %ld\n", (long)error.code];
        [output appendFormat:@"Description: %@\n", [error localizedDescription]];
        return output;
    }
    
    NSArray<USAutocompleteSuggestion*>* suggestions = lookup.result.suggestions;
    
    for (USAutocompleteSuggestion* suggestion in suggestions) {
        [output appendString:[suggestion.text stringByAppendingString:@"\n"]];
    }
    return output;
}

@end
