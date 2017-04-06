#import "SSUSStreetLookupsWithMatchStrategyExamples.h"

@implementation SSUSStreetLookupsWithMatchStrategyExamples

- (NSString*)run {
    SSUSStreetClient *client = [[SSClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].buildUsStreetApiClient;
    
    SSBatch *batch = [[SSBatch alloc] init];
    NSError *error = nil;
    
    SSUSStreetLookup *addressWithStrictStrategy = [[SSUSStreetLookup alloc] init];
    addressWithStrictStrategy.street = @"691 W 1150 S";
    addressWithStrictStrategy.city = @"provo";
    addressWithStrictStrategy.state = @"utah";
    addressWithStrictStrategy.matchStrategy = kSSStrict;
    
    SSUSStreetLookup *addressWithRangeStrategy = [[SSUSStreetLookup alloc] init];
    addressWithRangeStrategy.street = @"693 W 1150 S";
    addressWithRangeStrategy.city = @"provo";
    addressWithRangeStrategy.state = @"utah";
    addressWithRangeStrategy.matchStrategy = kSSRange;
    
    SSUSStreetLookup *addressWithInvalidStrategy = [[SSUSStreetLookup alloc] init];
    addressWithInvalidStrategy.street = @"9999 W 1150 S";
    addressWithInvalidStrategy.city = @"provo";
    addressWithInvalidStrategy.state = @"utah";
    addressWithInvalidStrategy.matchStrategy = kSSInvalid;
    
    [batch add:addressWithStrictStrategy error:&error];
    [batch add:addressWithRangeStrategy error:&error];
    [batch add:addressWithInvalidStrategy error:&error];
    
    if (error != nil) {
        if ([error.domain isEqualToString:@"SSSmartyErrorDomain"] && error.code == BatchFullError) {
            NSLog(@"Description: %@", [error localizedDescription]);
            return @"Error. The batch is already full.";
        }
    }
    
    [client sendBatch:batch error:&error];
    
    if (error != nil) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return @"Error sending request";
    }
    
    NSArray<SSUSStreetLookup*> *lookups = batch.allLookups;
    NSMutableString *output = [[NSMutableString alloc] init];
    
    for (int i = 0; i < batch.count; i++) {
        NSArray<SSUSStreetCandidate*> *candidates = [[lookups objectAtIndex:i] result];
        
        if (candidates.count == 0) {
            [output appendString:[NSString stringWithFormat:@"\nAddress %i is invalid\n", i]];
            continue;
        }
        
        [output appendString:[NSString stringWithFormat:@"\nAddress %i is valid. (There is at least one candidate)", i]];
        
        for (SSUSStreetCandidate *candidate in candidates) {
            SSUSStreetComponents const *components = candidate.components;
            SSUSStreetMetadata const *metadata = candidate.metadata;
            
            [output appendString:[NSString stringWithFormat:@"\n\nCandidate %i ", candidate.candidateIndex]];
            SSUSStreetLookup *lookup = [batch getLookupAtIndex:i];
            NSString *match = lookup.matchStrategy;
            [output appendString:[NSString stringWithFormat:@"with %@ strategy", match]];
            [output appendString:[@"\nDelivery line 1:  " stringByAppendingString:candidate.deliveryLine1]];
            [output appendString:[@"\nLast line:        " stringByAppendingString:candidate.lastline]];
            
            if (components.zipCode != nil)
                [output appendString:[@"\nZIP Code:         " stringByAppendingString:components.zipCode]];
            if (components.plus4Code != nil)
                [output appendString:[@"-" stringByAppendingString:components.plus4Code]];
            if (metadata.countyName != nil)
                [output appendString:[@"\nCounty:           " stringByAppendingString:metadata.countyName]];
            
            NSNumber *latitude = [NSNumber numberWithDouble:metadata.latitude];
            NSNumber *longitute = [NSNumber numberWithDouble:metadata.longitude];
            [output appendString:[@"\nLatitude:         " stringByAppendingString:[latitude stringValue]]];
            [output appendString:[@"\nLongitude:        " stringByAppendingString:[longitute stringValue]]];
        }
        
        [output appendString:@"\n***********************************\n"];
    }
    
    NSLog(@"Output = %@", output);
    return output;
}

@end
