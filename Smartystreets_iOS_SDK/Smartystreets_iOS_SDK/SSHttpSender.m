#import "SSHttpSender.h"

@interface SSHttpSender()
    
@property (nonatomic) int maxTimeout;
//@property (nonatomic) HttpTransport transport; //TODO: Java uses this line. figure out what to do for Objective-C

@end

@implementation SSHttpSender

- (instancetype)init {
    if (self = [super init]) {
        _maxTimeout = 10000;
//        _transport = [[NetHttpTransport alloc] init]; //TODO: Java uses this line. figure out what to do for Objective-C
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
}

- (SSResponse*)buildResponse:(NSMutableURLRequest*)httpRequest {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    __block SSResponse *myResponse;
    [[session dataTaskWithRequest:httpRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            int statusCode = (int)[(NSHTTPURLResponse *) response statusCode];
            NSData *payload = data;
            myResponse = [[SSResponse alloc] initWithStatusCode:statusCode payload:payload];
        }
    }] resume];
    
    return myResponse;
}

@end
