#import "SSHttpSender.h"

@interface SSHttpSender() {
    __block SSSmartyResponse *myResponse;
}
    
@property (nonatomic) int maxTimeout;
@property (nonatomic) NSDictionary *proxy;
@property (nonatomic) bool debug;

@end

@implementation SSHttpSender

- (instancetype)init {
    if (self = [super init]) {
        _maxTimeout = 10000;
        _debug = false;
    }
    return self;
}

- (instancetype)initWithMaxTimeout:(int)maxTimeout andProxy:(NSDictionary*)proxy andDebug:(bool)debug{
    if (self = [[super self] init]) {
        _maxTimeout = maxTimeout;
        _proxy = proxy;
        _debug = debug;
    }
    return self;
}

- (SSSmartyResponse*)sendRequest:(SSSmartyRequest*)request error:(NSError**)error {
    NSMutableURLRequest *httpRequest = [self buildHttpRequest:request];
    [self copyHeaders:request httpRequest:httpRequest];
    
    return [self buildResponse:httpRequest];
}

- (NSMutableURLRequest*)buildHttpRequest:(SSSmartyRequest*)request {
    NSURL *url = [NSURL URLWithString:[request getUrl]];
    
    NSMutableURLRequest *httpRequest = [NSMutableURLRequest requestWithURL:url];;
    if ([request.method isEqualToString:@"GET"]) {
        [httpRequest setHTTPMethod:@"GET"];
    }
    else {
        [httpRequest setHTTPMethod:@"POST"];
        [httpRequest setHTTPBody:request.payload];
    }
    return httpRequest;
}

- (void)copyHeaders:(SSSmartyRequest*)request httpRequest:(NSMutableURLRequest*)httpRequest {
    for (NSString *key in [request.headers allKeys])
        [httpRequest addValue:request.headers[key] forHTTPHeaderField:key];
    
    NSString *version = [[NSBundle bundleForClass:[@"SmartystreetsSDK" class]] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *userAgent = [[@"smartystreets (sdk:ios@" stringByAppendingString:version] stringByAppendingString:@")"];
    
    [httpRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
}

- (SSSmartyResponse*)buildResponse:(NSMutableURLRequest*)httpRequest {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    configuration.connectionProxyDictionary = _proxy;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, _maxTimeout * 1000000);
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:httpRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                int statusCode = (int)[(NSHTTPURLResponse *) response statusCode];
                NSData *payload = data;
                
                if(self->_debug)
                    [self logHttpRequest:httpRequest andResponse:(NSHTTPURLResponse *)response withPayload:payload];
                
                self->myResponse = [[SSSmartyResponse alloc] initWithStatusCode:statusCode payload:payload];
                dispatch_semaphore_signal(semaphore);
            }
        }];
    
    [task resume];
    dispatch_semaphore_wait(semaphore, timeout);
    
    return myResponse;
}

- (void)logHttpRequest:(NSMutableURLRequest*)httpRequest andResponse:(NSHTTPURLResponse*)response withPayload:(NSData*)payload {
    NSMutableString *message = [[NSMutableString alloc]init];
    [message appendString:@"\n***Request***\n"];
    [message appendFormat:@"\nMethod: %@\n", [httpRequest HTTPMethod] ];
    [message appendFormat:@"\nURL: %@\n", [httpRequest URL]];
    [message appendFormat:@"\nHeaders: %@\n", [httpRequest allHTTPHeaderFields]];
    [message appendFormat:@"\nRequest body:\n%@\n", [ [NSString alloc] initWithData:[httpRequest HTTPBody] encoding:NSUTF8StringEncoding] ];
    
    [message appendString:@"\n***Response***\n"];
    [message appendFormat:@"\nHeaders:\n%@\n", [response allHeaderFields]];
    [message appendFormat:@"\nStatus: %d\n", (int)[response statusCode]];
    [message appendFormat:@"\nBody: \n%@\n", [ [NSString alloc] initWithData:payload encoding:NSUTF8StringEncoding] ];
    NSLog(@"%@", message);
}

@end
