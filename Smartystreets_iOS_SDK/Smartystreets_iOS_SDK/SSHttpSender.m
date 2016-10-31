#import "SSHttpSender.h"

@interface SSHttpSender()
    
@property (nonatomic) int maxTimeout;
@property (nonatomic) SSResponse* theResponse; //TODO: try to not make this a field
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
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
//    __block SSResponse *myResponse;
    
//    [NSURLConnection sendAsynchronousRequest:httpRequest
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:
//     ^(NSURLResponse *response, NSData *data, NSError *error)
//     {
//         if (error == nil) {
//             int statusCode = (int)[(NSHTTPURLResponse *) response statusCode];
//             NSData *payload = data;
//             _theResponse = [self setResponse:statusCode payload:payload];
//         }
//     }
//     ];
    
//    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:httpRequest
//                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//    {
////        dispatch_async(dispatch_get_main_queue(), ^{
//            if (error == nil) {
//                int statusCode = (int)[(NSHTTPURLResponse *) response statusCode];
//                NSData *payload = data;
//                _theResponse = [self setResponse:statusCode payload:payload];
////
////            }
//        }/*)*/;
//    }];
//    
//    [task resume];
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:httpRequest
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if(error == nil) {
                                                    int statusCode = (int)[(NSHTTPURLResponse *) response statusCode];
                                                    NSData *payload = data;
                                                    
                                                    NSString * payloadText = [[NSString alloc] initWithData:payload encoding: NSUTF8StringEncoding];
//                                                    NSLog(@"Data = %@", payloadText); //TODO: delete line
//                                                    NSLog(@"Status Code = %@", statusCode); //TODO: delete line
                                                    
                                                    _theResponse = [self setResponse:statusCode payload:payload];
                                                }
                                            }];
    
    [task resume];
    
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1, false);
    
    
    return self.theResponse;
//    return myResponse;
}

- (SSResponse*)setResponse:(int)statusCode payload:(NSData*)payload {
    return [[SSResponse alloc] initWithStatusCode:statusCode payload:payload];;
}

- (NSURLSession*) getURLSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                      session = [NSURLSession sessionWithConfiguration:configuration];
                  });
    return session;
}

@end
