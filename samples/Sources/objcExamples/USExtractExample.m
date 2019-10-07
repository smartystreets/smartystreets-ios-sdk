#import "USExtractExample.h"

@interface USExtractExample ()

@end

@implementation USExtractExample

- (NSString*)run {
    USExtractClient* client = [[ClientBuilder alloc] initWithId:@"ID" hostname:@"hostname"].buildUsExtractApiClient;
    NSError *error = nil;
    
    NSString *text = @"Here is some text.\r\nMy address is 3785 Las Vegs Av."
    "\r\nLos Vegas, Nevada."
    "\r\nMeet me at 1 Rosedale Baltimore Maryland, not at 123 Phony Street, Boise Idaho.";
    
    //            Documentation for input fields can be found at:
    //            https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields
    
    USExtractLookup *lookup = [[[USExtractLookup alloc] init] withTextWithText:text];
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (!success) {
        [output appendFormat:@"Domain: %@\n", error.domain];
        [output appendFormat:@"Error Code: %ld\n", (long)error.code];
        [output appendFormat:@"Description: %@\n", [error localizedDescription]];
        return output;
    }
    
    USExtractResult* result = lookup.result;
    USExtractMetadata* metadata = result.metadata;
    
    [output appendString:[NSString stringWithFormat:@"Found %@ addresses.\n", metadata.objcAddressCount]];
    [output appendString:[NSString stringWithFormat:@"%@ of them were valid.\n\n", metadata.objcVerifiedCount]];
    
    NSArray<USExtractAddress*>* addresses = result.addresses;
    
    [output appendString:@"Addresses: \n**********************\n"];
    
    for (USExtractAddress *address in addresses) {
        [output appendString:[NSString stringWithFormat:@"\n\"%@\"\n", address.text]];
        [output appendString:[@"\nVerified? " stringByAppendingString:address.isVerified ? @"YES" : @"NO"]];
        if ([address.candidates count] > 0) {
            [output appendString:@"\nMatches"];
            
            for (USStreetCandidate *candidate in address.candidates) {
                [output appendString:[NSString stringWithFormat:@"\n%@", candidate.deliveryLine1]];
                [output appendString:[NSString stringWithFormat:@"\n%@\n", candidate.lastline]];
            }
        }
        else {
            [output appendString:@"\n"];
        }
        [output appendString:@"**********************\n"];
    }
    
    return output;
}

@end
