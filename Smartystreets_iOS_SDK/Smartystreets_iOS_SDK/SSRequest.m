#import "SSRequest.h"

NSString *const kSSCharSet = @"UTF-8";

@interface SSRequest()

@property (readonly, nonatomic) NSString *urlPrefix;

@end

@implementation SSRequest

- (instancetype)init {
    if (self = [super init]) {
        _method = @"GET";
        _headers = [NSMutableDictionary new];
        _parameters = [NSMutableDictionary new];
    }
    return self;
}

- (instancetype)initWithUrlPrefix:(NSString *)urlPrefix {
    if (self = [[super self] init]) {
        _urlPrefix = urlPrefix;
    }
    return self;
}

- (void)setValue:(NSString*)value forHTTPHeaderField:(NSString*)name {
    self.headers[name] = value;
}

- (void)setValue:(NSString*)value forHTTPParameterField:(NSString*)name {
    if (name == nil || value == nil || [name length] == 0)
        return;
    
    self.parameters[name] = value;
}

- (NSString*)getUrl {
    NSMutableString *url = [self.urlPrefix mutableCopy];
    
    if (![url containsString:@"?"])
        [url appendString:@"?"];
    
    for (NSString *value in self.parameters) {
        if (![url hasSuffix:@"?"])
            [url appendString:@"&"];
        
        NSString *encodedName = [self urlEncode:value];
        NSString *encodedValue = [self urlEncode:[self.parameters valueForKey:value]];
        [url appendString:encodedName];
        [url appendString:@"="];
        [url appendString:encodedValue];
    }

    return url;
}
- (NSString*)urlEncode:(NSString*)value {
    NSString *const charactersToEscape = @"*'();:@&=+$,/?%#[]";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    value = [value stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    value = [value stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    return value;
}

- (void)setPayload:(NSMutableData *)payload {
    _method = @"POST";
    _payload = payload;
}

@end
