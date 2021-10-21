#import <Foundation/Foundation.h>
#import "main.h"

int main(int argc, const char * arv[]) {
    NSLog(@"US Street Single Example: \n%@", [[[USStreetSingleExample alloc] init] run]);
    NSLog(@"US Street Multiple Example: \n%@", [[[USStreetMultipleExample alloc] init] run]);
    NSLog(@"US ZIP Code Single Example: \n%@", [[[USZipCodeSingleExample alloc] init] run]);
    NSLog(@"US ZIP Code Multiple Example: \n%@", [[[USZipCodeMultipleExample alloc] init] run]);
    NSLog(@"US Extract Example: \n%@", [[[USExtractExample alloc] init] run]);
    NSLog(@"US Autocomplete Pro Example: \n%@", [[[USAutocompleteProExample alloc] init] run]);
    NSLog(@"International Street Example: \n%@", [[[InternationalStreetExample alloc] init] run]);
    NSLog(@"International Autocomplete Example: \n%@", [[[InternationalAutocompleteExample alloc] init] run]);
    return 0;
}
