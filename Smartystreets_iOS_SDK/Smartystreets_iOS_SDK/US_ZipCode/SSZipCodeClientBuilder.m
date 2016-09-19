#import "SSZipCodeClientBuilder.h"

@interface SSZipCodeClientBuilder()

@property (nonatomic) id<SSCredentials> signer;
@property (nonatomic) id<SSSerializer> serializer;
@property (nonatomic) id<SSSender> httpSender;
@property (nonatomic) int maxRetries;
@property (nonatomic) int maxTimeout;
@property (nonatomic) NSString *urlPrefix;

@end

@implementation SSZipCodeClientBuilder

- (instancetype)init {
    if (self = [super init]) {
        _serializer = [[SSJsonSerializer alloc] init];
        _maxRetries = 5;
        _maxTimeout = 10000;
        _urlPrefix = @"https://us-zipcode.api.smartystreets.com/lookup";
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

- (SSZipCodeClientBuilder*)retryAtMost:(int)maxRetries {
    _maxRetries = maxRetries;
    return self;
}

- (SSZipCodeClientBuilder*)withMaxTimeout:(int)maxTimeout {
    _maxTimeout = maxTimeout;
    return self;
}

- (SSZipCodeClientBuilder*)withSender:(id<SSSender>)sender {
    _httpSender = sender;
    return self;
}

- (SSZipCodeClientBuilder*)withSerializer:(id<SSSerializer>)serializer {
    _serializer = serializer;
    return self;
}

- (SSZipCodeClientBuilder*)withUrl:(NSString*)urlPrefix {
    _urlPrefix = urlPrefix;
    return self;
}

- (SSZipCodeClient*)build {
    SSZipCodeClient *client = [[SSZipCodeClient alloc] initWithUrlPrefix:self.urlPrefix withSender:[self buildSender] withSerializer:self.serializer];
    return client;
}

- (id<SSSender>)buildSender {
    if (self.httpSender != nil)
        return self.httpSender;
    
    id<SSSender> sender = [[SSHttpSender alloc] initWithMaxTimeout:self.maxTimeout];
    
    sender = [[SSStatusCodeSender alloc] initWithInner:sender];
    
    if (self.signer != nil)
        sender = [[SSSigningSender alloc] initWithSigner:self.signer inner:sender];
    
    if (self.maxRetries > 0)
        sender = [[SSRetrySender alloc] initWithMaxRetries:self.maxRetries inner:sender];
    
    return sender;
}

@end





