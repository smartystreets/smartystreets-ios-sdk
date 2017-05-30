#import "SSInternationalStreetClient.h"

@interface SSInternationalStreetClient()

@property (readonly, nonatomic) id<SSSender> sender;
@property (readonly, nonatomic) id<SSSerializer> serializer;

@end

@implementation SSInternationalStreetClient

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer {
    if (self = [super init]) {
        _sender = sender;
        _serializer = serializer;
    }
    return self;
}

- (BOOL)sendLookup:(SSInternationalStreetLookup*)lookup error:(NSError**)error {
    [self ensureEnoughInfo:lookup error:error];
    SSSmartyRequest *request = [self buildRequest:lookup];
    
    SSSmartyResponse *response = [self.sender sendRequest:request error:error];
    if (*error != nil) return NO;
    
    NSArray<SSInternationalStreetCandidate*> *candidates = [self.serializer deserialize:response.payload error:error];
    if (*error != nil) return NO;
    
    if (candidates == nil)
        candidates = [[NSArray<SSInternationalStreetCandidate*> alloc] init];
    [self assignResultsToLookup:lookup withCandidates:candidates];

    if (*error != nil) return NO;
    
    return YES;
}

- (SSSmartyRequest*)buildRequest:(SSInternationalStreetLookup*)lookup {
    SSSmartyRequest *request = [[SSSmartyRequest alloc] init];
    
    [request setValue:lookup.country forHTTPParameterField:@"country"];
    [request setValue:lookup.geocode forHTTPParameterField:@"geocode"];
    if (lookup.language != nil)
        [request setValue:lookup.language.name forHTTPParameterField:@"language"];
    [request setValue:lookup.freeform forHTTPParameterField:@"freeform"];
    [request setValue:lookup.address1 forHTTPParameterField:@"address1"];
    [request setValue:lookup.address2 forHTTPParameterField:@"address2"];
    [request setValue:lookup.address3 forHTTPParameterField:@"address3"];
    [request setValue:lookup.address4 forHTTPParameterField:@"address4"];
    [request setValue:lookup.organization forHTTPParameterField:@"organization"];
    [request setValue:lookup.locality forHTTPParameterField:@"locality"];
    [request setValue:lookup.administrativeArea forHTTPParameterField:@"administrative_area"];
    [request setValue:lookup.postalCode forHTTPParameterField:@"postal_code"];
    
    return request;
}

- (void)ensureEnoughInfo:(SSInternationalStreetLookup*)lookup error:(NSError**)error {
    if ([lookup missingCountry]) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"Country field is required."};
        *error = [NSError errorWithDomain:SSErrorDomain code:UnprocessableEntityError userInfo:details];
        return;
    }
    
    if ([lookup hasFreeform])
        return;
    
    if ([lookup missingAddress1]) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"Either freeform or address1 is required."};
        *error = [NSError errorWithDomain:SSErrorDomain code:UnprocessableEntityError userInfo:details];
        return;
    }

    if ([lookup hasPostalCode])
        return;
    
    if ([lookup missingLocalityOrAdministrativeArea]) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"Insufficient information: One or more required fields were not set on the lookup."};
        *error = [NSError errorWithDomain:SSErrorDomain code:UnprocessableEntityError userInfo:details];
        return;
    }
}

- (void)assignResultsToLookup:(SSInternationalStreetLookup*)lookup withCandidates:(NSArray*)candidates {
    NSMutableArray<SSInternationalStreetCandidate*> *result = [NSMutableArray new];
    
    for (int i = 0; i < [candidates count]; i++) {
        SSInternationalStreetCandidate *candidate = [[SSInternationalStreetCandidate alloc] initWithDictionary:[candidates objectAtIndex:i]];
        [result addObject:candidate];
    }
    lookup.result = result;
}

@end
