#import "SSUSStreetClient.h"

@interface SSUSStreetClient()

@property (readonly, nonatomic) id<SSSender> sender;
@property (readonly, nonatomic) id<SSSerializer> serializer;

@end

@implementation SSUSStreetClient

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer {
    if (self = [super init]) {
        _sender = sender;
        _serializer = serializer;
    }
    return self;
}

- (BOOL)sendLookup:(SSUSStreetLookup*)lookup error:(NSError**)error {
    SSUSStreetBatch *batch = [[SSUSStreetBatch alloc] init];
    [batch add:lookup error:error];
    return [self sendBatch:batch error:error];
}

- (BOOL)sendBatch:(SSUSStreetBatch*)batch error:(NSError**)error {
    SSRequest *request = [[SSRequest alloc] init];
    
    if ([batch count] == 0) return NO;
    
    if ([batch count] == 1)
        [self populateQueryString:[batch getLookupAtIndex:0] withRequest:request];
    else
        [request setPayload:[self.serializer serialize:batch.allLookups withClassType:[SSUSStreetLookup class] error:error]];
    
    SSResponse *response = [self.sender sendRequest:request error:error];
    if (*error != nil) return NO;
    
    NSArray<SSUSStreetCandidate*> *candidates = [self.serializer deserialize:response.payload error:error];
    if (*error != nil) return NO;
    
    if (candidates == nil)
        candidates = [[NSArray<SSUSStreetCandidate*> alloc] init];
    [self assignCandidatesToLookups:batch candidates:candidates];
    
    if (*error != nil) return NO;
    
    return YES;
}

- (void)populateQueryString:(SSUSStreetLookup*)lookup withRequest:(SSRequest*)request {
    [request setValue:lookup.street forHTTPParameterField:@"street"];
    [request setValue:lookup.street2 forHTTPParameterField:@"street2"];
    [request setValue:lookup.secondary forHTTPParameterField:@"secondary"];
    [request setValue:lookup.city forHTTPParameterField:@"city"];
    [request setValue:lookup.state forHTTPParameterField:@"state"];
    [request setValue:lookup.zipCode forHTTPParameterField:@"zipcode"];
    [request setValue:lookup.lastline forHTTPParameterField:@"lastline"];
    [request setValue:lookup.addressee forHTTPParameterField:@"addressee"];
    [request setValue:lookup.urbanization forHTTPParameterField:@"urbanization"];
    
    if (lookup.maxCandidates != 1)
        [request setValue:[[NSNumber numberWithInt:lookup.maxCandidates] stringValue] forHTTPParameterField:@"candidates"];
    
    [request setValue:lookup.matchStrategy forHTTPHeaderField:@"match"];
}

- (void)assignCandidatesToLookups:(SSUSStreetBatch*)batch candidates:(NSArray*)candidates {
    for (int i = 0; i < [candidates count]; i++) {
        SSUSStreetCandidate *candidate = [[SSUSStreetCandidate alloc] initWithDictionary:[candidates objectAtIndex:i]];
        [[batch getLookupAtIndex:candidate.inputIndex] addToResult:candidate];
    }
}

@end
