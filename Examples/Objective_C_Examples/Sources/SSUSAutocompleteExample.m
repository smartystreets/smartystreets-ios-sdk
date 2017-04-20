#import "SSUSAutocompleteExample.h"

@implementation SSUSAutocompleteExample

- (NSString*)run {
    id<SSCredentials> mobile = [[SSSharedCredentials alloc] initWithId:kSSSmartyWebsiteKey hostname:kSSHost];
    SSUSAutocompleteClient *client = [[SSClientBuilder alloc] initWithSigner:mobile].buildUsAutocompleteClient;
    
    SSUSAutocompleteLookup *lookup = [[SSUSAutocompleteLookup alloc] initWithPrefix:@"4770 Lincoln Ave 0"];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    NSString *output = @"*** Result with no filter ***\n";
    
    NSArray<SSUSAutocompleteSuggestion*> *result1 = lookup.result;
    
    for (SSUSAutocompleteSuggestion *suggestion in result1) {
        [output stringByAppendingString:suggestion.text];
        [output stringByAppendingString:@"\n"];
    }
    
    error = nil;
    
    [lookup addStateFilter:@"IL"];
    [lookup setMaxSuggestions:5 error:&error];
    
    [client sendLookup:lookup error:&error];
    
    NSArray<SSUSAutocompleteSuggestion*> *result2 = lookup.result;
    
    [output stringByAppendingString:@"\n***Result with snot filters ***\n"];
    for (SSUSAutocompleteSuggestion *suggestion in result2) {
        [output stringByAppendingString:suggestion.text];
        [output stringByAppendingString:@"\n"];
    }
    
    return output;
}

@end
