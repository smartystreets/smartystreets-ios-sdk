#import "SSStreetClient.h"

@interface SSStreetClient()

@property (readonly, nonatomic) NSString *urlPrefix;
@property (readonly, nonatomic) id<SSSender> sender;
@property (readonly, nonatomic) id<SSSerializer> serializer;

@end

@implementation SSStreetClient

- (instancetype)initWithUrlPrefix:(NSString*)urlPrefix withSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer {
    if (self = [super init]) {
        _urlPrefix = urlPrefix;
        _sender = sender;
        _serializer = serializer;
    }
    return self;
}

- (void)sendLookup:(SSStreetLookup*)lookup error:(NSError**)error {
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    [batch add:lookup error:error];
    [self sendBatch:batch error:error];
}

- (void)sendBatch:(SSStreetBatch*)batch error:(NSError**)error {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:self.urlPrefix];
    
    if ([batch count] == 0)
        return;
    
    [self putHeaders:batch request:request];
    
    if ([batch count] == 1)
        [self populateQueryString:[batch getLookupAtIndex:0] withRequest:request];
    else
        [request setPayload:[self.serializer serialize:batch.allLookups]];
    
    SSResponse *response = [self.sender sendRequest:request withError:error];
    
    NSArray<SSCandidate*> *candidates = [self.serializer deserialize:response.payload withClassType:[SSCandidate class]];
    if (candidates == nil)
        candidates = [[NSArray<SSCandidate*> alloc] init];
    [self assignCandidatesToLookups:batch candidates:candidates];
}

- (void)putHeaders:(SSStreetBatch*)batch request:(SSRequest*)request {
    if (batch.includeInvalid)
        [request setValue:@"true" forHTTPHeaderField:@"X-Include-Invalid"];
    else if (batch.standardizeOnly)
        [request setValue:@"true" forHTTPHeaderField:@"X-Standardize-Only"];
}

- (void)populateQueryString:(SSStreetLookup*)lookup withRequest:(SSRequest*)request {
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
}

- (void)assignCandidatesToLookups:(SSStreetBatch*)batch candidates:(NSArray<SSCandidate*>*)candidates {
    for (SSCandidate *candidate in candidates)
         [[batch getLookupAtIndex:candidate.inputIndex] addToResult:candidate];
}

@end
