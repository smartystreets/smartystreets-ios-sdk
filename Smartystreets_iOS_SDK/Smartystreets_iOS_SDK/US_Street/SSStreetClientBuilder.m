#import "SSStreetClientBuilder.h"

@interface SSStreetClientBuilder()

@property (nonatomic) id<SSCredentials> signer;
@property (nonatomic) id<SSSerializer> serializer;
@property (nonatomic) id<SSSender> httpSender;
@property (nonatomic) int maxRetries;
@property (nonatomic) int maxTimeout;
@property (nonatomic) NSString *urlPrefix;

@end

@implementation SSStreetClientBuilder

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

- (SSStreetClientBuilder*)retryAtMost:(int)maxRetries {
    _maxRetries = maxRetries;
    return self;
}

- (SSStreetClientBuilder*)withMaxTimeout:(int)maxTimeout {
    _maxTimeout = maxTimeout;
    return self;
}

- (SSStreetClientBuilder*)withSender:(id<SSSender>)sender {
    _httpSender = sender;
    return self;
}

- (SSStreetClientBuilder*)withSerializer:(id<SSSerializer>)serializer {
    _serializer = serializer;
    return self;
}

- (SSStreetClientBuilder*)withUrl:(NSString*)urlPrefix {
    _urlPrefix = urlPrefix;
    return self;
}

- (SSStreetClient*)build {
    SSStreetClient *client = [[SSStreetClient alloc] initWithUrlPrefix:self.urlPrefix withSender:[self buildSender] withSerializer:self.serializer];
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
