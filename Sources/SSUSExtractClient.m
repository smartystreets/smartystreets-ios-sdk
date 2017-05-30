#import "SSUSExtractClient.h"

@interface SSUSExtractClient()

@property (readonly, nonatomic) id<SSSender> sender;
@property (readonly, nonatomic) id<SSSerializer> serializer;

@end

@implementation SSUSExtractClient

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer {
    if (self = [super init]) {
        _sender = sender;
        _serializer = serializer;
    }
    return self;
}

- (BOOL)sendLookup:(SSUSExtractLookup*)lookup error:(NSError**)error {
    if (lookup == nil || lookup.text == nil || [lookup.text length] == 0) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"sendLookup requires a Lookup with the 'text' field set"};
        *error = [NSError errorWithDomain:SSErrorDomain code:FieldNotSetError userInfo:details];
        return NO;
    }
    
    SSSmartyRequest *request = [self buildRequest:lookup];
    SSSmartyResponse * response = [self.sender sendRequest:request error:error];
    if (*error != nil) return NO;
    
    NSDictionary *result = [self.serializer deserialize:response.payload error:error];
    if (*error != nil) return NO;
    
    lookup.result = [[SSUSExtractResult alloc] initWithDictionary:result];
    if (*error != nil) return NO;
    
    return YES;
}

- (SSSmartyRequest*)buildRequest:(SSUSExtractLookup*)lookup {
    SSSmartyRequest *request = [[SSSmartyRequest alloc] init];
    request.contentType = @"text/plain";
    NSData *payload = [lookup.text dataUsingEncoding:NSUTF8StringEncoding];
    request.payload = payload;
    
    [request setValue:[self getStringValueOfBoolean:lookup.isHtml] forHTTPParameterField:@"html"];
    [request setValue:[self getStringValueOfBoolean:lookup.isAggressive] forHTTPParameterField:@"aggressive"];
    [request setValue:[self getStringValueOfBoolean:lookup.addressesHaveLineBreaks] forHTTPParameterField:@"addr_line_breaks"];
    [request setValue:[@(lookup.addressesPerLine) stringValue] forHTTPParameterField:@"addr_per_line"];
    
    return request;
}

- (NSString*)getStringValueOfBoolean:(bool)value {
    if (value)
        return @"true";
    else if (!value)
        return @"false";
    else
        return nil;
}

@end
