#import "ObjectiveCExtractExample.h"

@interface ObjectiveCExtractExample ()

@end

@implementation ObjectiveCExtractExample

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"lines-map"] drawInRect:self.view.bounds];
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
}

- (IBAction)Search:(UIButton *)sender {
    [self.view endEditing:true];
    _result.text = [self run];
}

- (NSString*)run {
    USExtractClient* client = [[ClientBuilder alloc] initWithId:@"key" hostname:@"hostname"].buildUsExtractApiClient;
    
    //            Documentation for input fields can be found at:
    //            https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields
    
    USExtractLookup* lookup = [[[USExtractLookup alloc] init] withTextWithText:_input.text];
    NSError* error = nil;
    
    _Bool success = [client sendLookupWithLookup:&lookup error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    
    USExtractResult* result = lookup.result;
    USExtractMetadata* metadata = result.metadata;
    NSMutableString *output = [NSMutableString new];
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

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
