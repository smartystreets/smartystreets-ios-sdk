#import "SSUSZipCodeClient.h"

@interface SSUSZipCodeClient()

@property (readonly, nonatomic) NSString *urlPrefix;
@property (readonly, nonatomic) id<SSSender> sender;
@property (readonly, nonatomic) id<SSSerializer> serializer;

@end

@implementation SSUSZipCodeClient

- (instancetype)initWithUrlPrefix:(NSString*)urlPrefix withSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer {
    if (self = [super init]) {
        _urlPrefix = urlPrefix;
        _sender = sender;
        _serializer = serializer;
    }
    return self;
}

- (BOOL)sendLookup:(SSUSZipCodeLookup*)lookup error:(NSError**)error {
    SSUSZipCodeBatch *batch = [[SSUSZipCodeBatch alloc] init];
    [batch add:lookup error:error];
    return [self sendBatch:batch error:error];
}

- (BOOL)sendBatch:(SSUSZipCodeBatch*)batch error:(NSError**)error {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:self.urlPrefix];
    
    if ([batch count] == 0)
        return NO;
    
    if ([batch count] == 1)
        [self populateQueryString:[batch getLookupAtIndex:0] withRequest:request];
    else
        [request setPayload:[self.serializer serialize:batch.allLookups withClassType:[SSUSZipCodeLookup class] error:error]];
    
    SSResponse *response = [self.sender sendRequest:request error:error];
    
    if (*error != nil)
        return NO;
    
    NSArray *resultsDict = [self.serializer deserialize:response.payload withClassType:[SSUSZipCodeResult class] error:error];
    
    if (*error != nil)
        return NO;
    
    if (resultsDict == nil)
        resultsDict = [NSArray<SSUSZipCodeResult*> new];

    [self assignResultsToLookups:batch result:resultsDict];
    
    if (*error != nil)
        return NO;
    
    return YES;
}

- (void)populateQueryString:(SSUSZipCodeLookup*)lookup withRequest:(SSRequest*)request {
    [request setValue:lookup.inputId forHTTPParameterField:@"input_id"];
    [request setValue:lookup.city forHTTPParameterField:@"city"];
    [request setValue:lookup.state forHTTPParameterField:@"state"];
    [request setValue:lookup.zipcode forHTTPParameterField:@"zipcode"];
}

- (void)assignResultsToLookups:(SSUSZipCodeBatch*)batch result:(NSArray*)results {
    for (int i = 0; i < [results count]; i++)
        [[batch getLookupAtIndex:i] setResult:[results objectAtIndex:i]];
}

@end
