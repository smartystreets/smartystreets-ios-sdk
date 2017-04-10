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
//    [self ensureEnoughInfo:lookup];
    SSRequest *request = [self buildRequest:lookup];
    
    SSResponse *response = [self.sender sendRequest:request error:error];
    if (*error != nil) return NO;
    
    NSArray<SSInternationalStreetCandidate*> *candidates = [self.serializer deserialize:response.payload error:error];
    if (*error != nil) return NO;
    
    if (candidates == nil)
        candidates = [[NSArray<SSInternationalStreetCandidate*> alloc] init];
    [self assignResultsToLookup:lookup withCandidates:candidates];

    if (*error != nil) return NO;
    
    return YES;
}

- (SSRequest*)buildRequest:(SSInternationalStreetLookup*)lookup {
    SSRequest *request = [[SSRequest alloc] init];
    
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

- (void)ensureEnoughInfo:(SSInternationalStreetLookup*)lookup {
    
}

- (void)assignResultsToLookup:(SSInternationalStreetLookup*)lookup withCandidates:(NSArray<SSInternationalStreetCandidate*>*)candidates {
    
}

@end
