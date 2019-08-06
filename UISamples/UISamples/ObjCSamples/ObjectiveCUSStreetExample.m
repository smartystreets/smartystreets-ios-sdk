#import "ObjectiveCUSStreetExample.h"

@interface ObjectiveCUSStreetExample ()

@end

@implementation ObjectiveCUSStreetExample

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"lines-map"] drawInRect:self.view.bounds];
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
    
    _batch = [[USStreetBatch alloc] init];
}

- (IBAction)search:(UIButton *)sender {
    _result.text = [self run];
}

- (IBAction)add:(UIButton *)sender {
    USStreetLookup* lookup = [[USStreetLookup alloc] init];
    if ([_freeform.text length] > 0) {
        lookup = [[USStreetLookup alloc] initWithFreeformAddress:_freeform.text];
    } else {
        lookup.street = _street.text;
        lookup.city = _city.text;
        lookup.state = _state.text;
    }
    
    NSError* error = nil;
    
    _Bool success = [_batch addWithNewAddress:lookup error:&error];
    
    if (!success) {
        NSLog(@"Description: %@", [error localizedDescription]);
        _result.text = error.localizedDescription;
        return;
    }
}

- (NSString *)run {
    NSString* authId = @"af79ba24-4971-9d11-ec86-e0c768a7694e";
    NSString* authToken = @"DGQcdrLC2TmOm913YUe7";
    USStreetClient* client = [[ClientBuilder alloc] initWithAuthId:authId authToken:authToken].buildUsStreetApiClient;
    NSError* error = nil;
    
    _Bool success = [client sendBatchWithBatch:_batch error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return error.localizedDescription;
    }
    
    NSArray<USStreetLookup*>* lookups = _batch.allLookups;
    NSMutableString* output = [[NSMutableString alloc] init];
    
    for (int i = 0; i < _batch.count; i++) {
        NSArray<USStreetCandidate*> *candidates = [[lookups objectAtIndex:i] result];
        
        if (candidates.count == 0) {
            [output appendString:[NSString stringWithFormat:@"\nAddress %i is invalid\n", i]];
            continue;
        }
        
        [output appendString:[NSString stringWithFormat:@"\nAddress %i is valid. (There is at least one candidate)", i]];
        
        for (USStreetCandidate *candidate in candidates) {
            USStreetComponents const *components = candidate.components;
            USStreetMetadata const *metadata = candidate.metadata;
            
            [output appendString:[NSString stringWithFormat:@"\n\nCandidate %@ :", candidate.objcCandidateIndex]];
            [output appendString:[@"\nDelivery line 1:  " stringByAppendingString:candidate.deliveryLine1]];
            [output appendString:[@"\nLast line:        " stringByAppendingString:candidate.lastline]];
            [output appendString:[@"\nZIP Code:         " stringByAppendingString:components.zipCode]];
            [output appendString:[@"-" stringByAppendingString:components.plus4Code]];
            [output appendString:[@"\nCounty:           " stringByAppendingString:metadata.countyName]];
            [output appendString:[@"\nLatitude:         " stringByAppendingString:[metadata.objcLatitude stringValue]]];
            [output appendString:[@"\nLongitude:        " stringByAppendingString:[metadata.objcLongitude stringValue]]];
        }
        
        [output appendString:@"\n***********************************\n"];
    }
    
    NSLog(@"Output = %@", output);
    return output;
}

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
