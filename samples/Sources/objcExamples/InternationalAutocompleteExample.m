#import "InternationalAutocompleteExample.h"

@interface InternationalAutocompleteExample ()

@end

@implementation InternationalAutocompleteExample

- (NSString*)run {
    //            The appropriate license values to be used for your subscriptions
    //            can be found on the Subscriptions page of the account dashboard.
    //            https://www.smartystreets.com/docs/cloud/licensing
    InternationalAutocompleteClient* client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].withLicenses(["international-global-plus-cloud"]).buildInternationalAutocompleteApiClient;
    
    // Documentation for input fields can be found at:
    // https://smartystreets.com/docs/cloud/international-street-api#http-input-fields
    InternationalAutocompleteLookup *lookup = [[InternationalAutocompleteLookup alloc] init];
    lookup.country = "FRA";
    lookup.locality = "Paris";
    lookup.search = "Louis";
    NSError *error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (!success) {
        [output appendFormat:@"Domain: %@\n", error.domain];
        [output appendFormat:@"Error Code: %ld\n", (long)error.code];
        [output appendFormat:@"Description: %@\n", [error localizedDescription]];
        return output;
    }
    
    NSArray<InternationalAutocompleteCandidate*>* candidates = lookup.result.candidates;
    
    for (InternationalAuocompleteCandidate* candidate in candidates) {
        [output appendString:[candidate.street stringByAppendingString:@" "]];
        [output appendString:[candidate.locality stringByAppendingString:@" "]];
        [output appendString:[candidate.administrativeArea stringByAppendingString:@", "]];
        [output appendString:[candidate.countryISO3 stringByAppendingString:@"\n"]];
    }
    
    return output;
}

@end
