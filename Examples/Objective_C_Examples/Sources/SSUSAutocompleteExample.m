#import "SSUSAutocompleteExample.h"

@implementation SSUSAutocompleteExample

- (NSString*)run {
    id<SSCredentials> mobile = [[SSSharedCredentials alloc] initWithId:kSSSmartyWebsiteKey hostname:kSSHost];
    SSUSAutocompleteClient *client = [[SSClientBuilder alloc] initWithSigner:mobile].buildUsAutocompleteApiClient;
    
    SSUSAutocompleteLookup *lookup = [[SSUSAutocompleteLookup alloc] initWithPrefix:@"4770 Lincoln Ave O"];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    NSMutableString *output = [[NSMutableString alloc] init];
    [output appendString:@"*** Result with no filter ***\n"];
    
    NSArray<SSUSAutocompleteSuggestion*> *result1 = lookup.result;
    
    for (SSUSAutocompleteSuggestion *suggestion in result1)
        [output appendString:[suggestion.text stringByAppendingString:@"\n"]];
    
    error = nil;
    
    [lookup addStateFilter:@"IL"];
    [lookup setMaxSuggestions:5 error:&error];
    
    [client sendLookup:lookup error:&error];
    
    NSArray<SSUSAutocompleteSuggestion*> *result2 = lookup.result;
    
    [output appendString:@"\n***Result with some filters ***\n"];
    for (SSUSAutocompleteSuggestion *suggestion in result2)
        [output appendString:[suggestion.text stringByAppendingString:@"\n"]];
    
    return output;
}

@end
