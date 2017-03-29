#import "SSUSStreetClientBuilder.h"

@interface SSUSStreetClientBuilder()

@property (nonatomic) id<SSCredentials> signer;
@property (nonatomic) id<SSSerializer> serializer;
@property (nonatomic) id<SSSender> httpSender;
@property (nonatomic) int maxRetries;
@property (nonatomic) int maxTimeout;
@property (nonatomic) NSString *urlPrefix;

@end

@implementation SSUSStreetClientBuilder

- (instancetype)init {
    if (self = [super init]) {
        _serializer = [[SSJsonSerializer alloc] init];
        _maxRetries = 5;
        _maxTimeout = 10000;
        _urlPrefix = @"https://api.smartystreets.com/street-address";
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

- (SSUSStreetClientBuilder*)retryAtMost:(int)maxRetries {
    _maxRetries = maxRetries;
    return self;
}

- (SSUSStreetClientBuilder*)withMaxTimeout:(int)maxTimeout {
    _maxTimeout = maxTimeout;
    return self;
}

- (SSUSStreetClientBuilder*)withSender:(id<SSSender>)sender {
    _httpSender = sender;
    return self;
}

- (SSUSStreetClientBuilder*)withSerializer:(id<SSSerializer>)serializer {
    _serializer = serializer;
    return self;
}

- (SSUSStreetClientBuilder*)withUrl:(NSString*)urlPrefix {
    _urlPrefix = urlPrefix;
    return self;
}

- (SSUSStreetClient*)build {
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithUrlPrefix:self.urlPrefix withSender:[self buildSender] withSerializer:self.serializer];
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
