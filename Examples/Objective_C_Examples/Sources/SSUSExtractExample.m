#import "SSUSExtractExample.h"

@implementation SSUSExtractExample

- (NSString*)run {
    SSUSExtractClient *client = [[SSClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].buildUsExtractApiClient;
    
    NSMutableString *text = [NSMutableString new];
    [text appendString:@"Here is some text.\r\nMy address is 3785 Las Vegs Av."];
    [text appendString:@"\r\nLos Vegas, Nevada."];
    [text appendString:@"\r\nMeet me at 1 Rosedale Baltimore Maryland, not at 123 Phony Street, Boise Idaho."];
    
    SSUSExtractLookup *lookup = [[SSUSExtractLookup alloc] initWithText:text];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    SSUSExtractResult *result = lookup.result;
    SSUSExtractMetadata *metadata = result.metadata;
    NSMutableString *output = [NSMutableString new];
    [output appendString:[NSString stringWithFormat:@"Found %d addresses.\n", metadata.addressCount]];
    [output appendString:[NSString stringWithFormat:@"%d of them were valid.\n\n", metadata.verifiedCount]];
    
    NSArray<SSUSExtractAddress*> *addresses = result.addresses;
    
    [output appendString:@"Addresses: \n**********************\n"];
    
    for (SSUSExtractAddress *address in addresses) {
        [output appendString:[NSString stringWithFormat:@"\n\"%@\"\n", address.text]];
        [output appendString:[@"\nVerified? " stringByAppendingString:address.isVerified ? @"YES" : @"NO"]];
        if ([address.candidates count] > 0) {
            [output appendString:@"\nMatches"];
            
            for (SSUSStreetCandidate *candidate in address.candidates) {
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
