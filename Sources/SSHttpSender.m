#import "SSHttpSender.h"

@interface SSHttpSender()
    
@property (nonatomic) int maxTimeout;

@end

@implementation SSHttpSender

- (instancetype)init {
    if (self = [super init]) {
        _maxTimeout = 10000;
    }
    return self;
}

- (instancetype)initWithMaxTimeout:(int)maxTimeout {
    if (self = [[super self] init]) {
        _maxTimeout = maxTimeout;
    }
    return self;
}

- (SSResponse*)sendRequest:(SSRequest*)request error:(NSError**)error {
    NSMutableURLRequest *httpRequest = [self buildHttpRequest:request];
    [self copyHeaders:request httpRequest:httpRequest];
    
    return [self buildResponse:httpRequest];
}

- (NSMutableURLRequest*)buildHttpRequest:(SSRequest*)request {
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

- (void)copyHeaders:(SSRequest*)request httpRequest:(NSMutableURLRequest*)httpRequest {
    for (NSString *key in [request.headers allKeys])
        [httpRequest addValue:request.headers[key] forHTTPHeaderField:key];
    
    NSString *version = [[NSBundle bundleForClass:[@"Smartystreets_iOS_SDK" class]] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *userAgent = [[@"smartystreets (sdk:ios@" stringByAppendingString:version] stringByAppendingString:@")"];
    
    [httpRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
}

- (SSResponse*)buildResponse:(NSMutableURLRequest*)httpRequest {
    NSURLSession *session = [NSURLSession sharedSession];
    __block SSResponse *myResponse;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:httpRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                int statusCode = (int)[(NSHTTPURLResponse *) response statusCode];
                NSData *payload = data;
                
                myResponse = [[SSResponse alloc] initWithStatusCode:statusCode payload:payload];
            }
        }];
    
    [task resume];
    
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, .1, false);
    
    return myResponse;
}

@end
