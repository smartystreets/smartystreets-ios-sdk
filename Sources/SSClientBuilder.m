#import "SSClientBuilder.h"

@interface SSClientBuilder()

@property (nonatomic) id<SSCredentials> signer;
@property (nonatomic) id<SSSerializer> serializer;
@property (nonatomic) id<SSSender> httpSender;
@property (nonatomic) int maxRetries;
@property (nonatomic) int maxTimeout;
@property (nonatomic) bool debug;
@property (nonatomic) NSString *urlPrefix;
@property (nonatomic) NSDictionary *proxy;
@property (readonly, nonatomic) NSString *internationalStreetApiURL;
@property (readonly, nonatomic) NSString *usAutocopmleteApiURL;
@property (readonly, nonatomic) NSString *usExtractApiURL;
@property (readonly, nonatomic) NSString *usStreetApiURL;
@property (readonly, nonatomic) NSString *usZipCodeApiURL;

@end

@implementation SSClientBuilder

- (instancetype)init {
    if (self = [super init]) {
        _serializer = [[SSJsonSerializer alloc] init];
        _maxRetries = 5;
        _maxTimeout = 10000;
        _debug = false;
        _internationalStreetApiURL = @"https://international-street.api.smartystreets.com/verify";
        _usAutocopmleteApiURL = @"https://us-autocomplete.api.smartystreets.com/suggest";
        _usExtractApiURL = @"https://us-extract.api.smartystreets.com";
        _usStreetApiURL = @"https://us-street.api.smartystreets.com/street-address";
        _usZipCodeApiURL = @"https://us-zipcode.api.smartystreets.com/lookup";
    }
    return self;
}

- (instancetype)initWithSigner:(id<SSCredentials>)signer {
    if (self = [[super self] init])
        _signer = signer;
    return self;
}

- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken {
    SSStaticCredentials *credentials = [[SSStaticCredentials alloc] initWithAuthId:authId authToken:authToken];
    return [self initWithSigner:credentials];
}

- (SSClientBuilder*)retryAtMost:(int)maxRetries {
    _maxRetries = maxRetries;
    return self;
}

- (SSClientBuilder*)withMaxTimeout:(int)maxTimeout {
    _maxTimeout = maxTimeout;
    return self;
}

- (SSClientBuilder*)withSender:(id<SSSender>)sender {
    _httpSender = sender;
    return self;
}

- (SSClientBuilder*)withSerializer:(id<SSSerializer>)serializer {
    _serializer = serializer;
    return self;
}

- (SSClientBuilder*)withUrl:(NSString*)urlPrefix {
    _urlPrefix = urlPrefix;
    return self;
}

- (SSClientBuilder*)withProxy:(NSString*)host port:(int)portRaw {
    NSNumber* port = [NSNumber numberWithInt:portRaw];
    _proxy = @{
               @"HTTPEnable"  : [NSNumber numberWithInt:1],
               (NSString *)kCFStreamPropertyHTTPProxyHost  : host,
               (NSString *)kCFStreamPropertyHTTPProxyPort  : port,
               
               @"HTTPSEnable" : [NSNumber numberWithInt:1],
               (NSString *)kCFStreamPropertyHTTPSProxyHost : host,
               (NSString *)kCFStreamPropertyHTTPSProxyPort : port,
               };
    return self;
}

- (SSClientBuilder*)withDebug {
    _debug = true;
    return self;
}

- (SSInternationalStreetClient*)buildInternationalStreetApiClient {
    [self ensureURLPrefixNotNil:self.internationalStreetApiURL];
    return [[SSInternationalStreetClient alloc] initWithSender:[self buildSender] withSerializer:self.serializer];
}

- (SSUSAutocompleteClient*)buildUsAutocompleteApiClient {
    [self ensureURLPrefixNotNil:self.usAutocopmleteApiURL];
    return [[SSUSAutocompleteClient alloc] initWithSender:[self buildSender] withSerializer:self.serializer];
}

- (SSUSExtractClient*)buildUsExtractApiClient {
    [self ensureURLPrefixNotNil:self.usExtractApiURL];
    return [[SSUSExtractClient alloc] initWithSender:[self buildSender] withSerializer:self.serializer];
}

- (SSUSStreetClient*)buildUsStreetApiClient {
    [self ensureURLPrefixNotNil:self.usStreetApiURL];
    return [[SSUSStreetClient alloc] initWithSender:[self buildSender] withSerializer:self.serializer];
}

- (SSUSZipCodeClient*)buildUsZIPCodeApiClient {
    [self ensureURLPrefixNotNil:self.usZipCodeApiURL];
    return [[SSUSZipCodeClient alloc] initWithSender:[self buildSender] withSerializer:self.serializer];
}

- (id<SSSender>)buildSender {
    if (self.httpSender != nil)
        return self.httpSender;
    
    id<SSSender> sender = [[SSHttpSender alloc] initWithMaxTimeout:self.maxTimeout andProxy:self.proxy andDebug:self.debug];
    
    sender = [[SSStatusCodeSender alloc] initWithInner:sender];
    
    if (self.maxRetries > 0)
        sender = [[SSRetrySender alloc] initWithMaxRetries:self.maxRetries withSleeper:[[SSMySleeper alloc] init] withLogger:[[SSMyLogger alloc] init] inner:sender];
    
    if (self.signer != nil)
        sender = [[SSSigningSender alloc] initWithSigner:self.signer inner:sender];
    
    sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:self.urlPrefix inner:sender];
    
    return sender;
}

- (void)ensureURLPrefixNotNil:(NSString*)url {
    if (self.urlPrefix == nil)
        _urlPrefix = url;
}

@end
