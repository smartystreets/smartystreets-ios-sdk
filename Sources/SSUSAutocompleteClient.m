#import "SSUSAutocompleteClient.h"

@interface SSUSAutocompleteClient()

@property (readonly, nonatomic) id<SSSender> sender;
@property (readonly, nonatomic) id<SSSerializer> serializer;

@end

@implementation SSUSAutocompleteClient

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer {
    if (self = [super init]) {
        _sender = sender;
        _serializer = serializer;
    }
    return self;
}

- (BOOL)sendLookup:(SSUSAutocompleteLookup*)lookup error:(NSError**)error {
    if (lookup == nil || lookup.prefix == nil || [lookup.prefix length] == 0) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"sendLookup must be passed a Lookup with the prefix field set."};
        *error = [NSError errorWithDomain:SSErrorDomain code:FieldNotSetError userInfo:details];
        return NO;
    }
    
    SSSmartyRequest *request = [self buildRequest:lookup];
    
    SSSmartyResponse *response = [self.sender sendRequest:request error:error];
    if (*error != nil) return NO;
    
    NSDictionary *result = [self.serializer deserialize:response.payload error:error];
    if (result == nil) return NO;
    
    lookup.result = [[[SSUSAutocompleteResult alloc] initWithDictionary:result] suggestions];
    if (*error != nil) return NO;
    
    return YES;
}

- (SSSmartyRequest*)buildRequest:(SSUSAutocompleteLookup*)lookup {
    SSSmartyRequest *request = [[SSSmartyRequest alloc] init];
    
    [request setValue:lookup.prefix forHTTPParameterField:@"prefix"];
    [request setValue:[lookup GetMaxSuggestionsStringIfSet] forHTTPParameterField:@"suggestions"];
    [request setValue:[self buildFilterString:lookup.cityFilter] forHTTPParameterField:@"city_filter"];
    [request setValue:[self buildFilterString:lookup.stateFilter] forHTTPParameterField:@"state_filter"];
    [request setValue:[self buildFilterString:lookup.prefer] forHTTPParameterField:@"prefer"];
    [request setValue:[lookup GetPreferRatioStringIfSet] forHTTPParameterField:@"prefer_ratio"];
    
    if (lookup.geolocateType.name != kSSGeolocateTypeNone) {
        [request setValue:@"true" forHTTPParameterField:@"geolocate"];
        [request setValue:lookup.geolocateType.name forHTTPParameterField:@"geolocate_precision"];
    }
    else [request setValue:@"false" forHTTPParameterField:@"geolocate"];
    
    return request;
}

- (NSString*)buildFilterString:(NSMutableArray<NSString*>*)list {
    if ([list count] == 0)
        return nil;
    
    return [list componentsJoinedByString:@","];
}

@end
