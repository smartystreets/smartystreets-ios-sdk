#import "SSUSStreetMultipleLookupsExample.h"

@implementation SSUSStreetMultipleLookupsExample

- (NSString*)run {
    SSUSStreetClient *client = [[SSClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].buildUsStreetApiClient;
    
    SSBatch *batch = [[SSBatch alloc] init];
    NSError *error = nil;
    
    SSUSStreetLookup *address0 = [[SSUSStreetLookup alloc] init];
    address0.street = @"1600 amphitheatre parkway";
    address0.city = @"Mountain view";
    address0.state = @"california";
    address0.matchStrategy = @"invalid";
    
    SSUSStreetLookup *address1 = [[SSUSStreetLookup alloc] initWithFreeformAddress:@"1 Rosedale, Baltimore, Maryland"];
    [address1 setMaxCandidates:10 error:&error];
    
    SSUSStreetLookup *address2 = [[SSUSStreetLookup alloc] initWithFreeformAddress:@"123 Bogus Street, Pretend Lake, Oklahoma"];
    
    SSUSStreetLookup *address3 = [[SSUSStreetLookup alloc] init];
    address3.street = @"1 Infinite Loop";
    address3.zipCode = @"95014";
    
    [batch add:address0 error:&error];
    [batch add:address1 error:&error];
    [batch add:address2 error:&error];
    [batch add:address3 error:&error];
    
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
            
            [output appendString:[NSString stringWithFormat:@"\n\nCandidate %i :", candidate.candidateIndex]];
            [output appendString:[@"\nDelivery line 1:  " stringByAppendingString:candidate.deliveryLine1]];
            [output appendString:[@"\nLast line:        " stringByAppendingString:candidate.lastline]];
            [output appendString:[@"\nZIP Code:         " stringByAppendingString:components.zipCode]];
            [output appendString:[@"-" stringByAppendingString:components.plus4Code]];
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
