#import "SSStatusCodeSender.h"

@interface SSStatusCodeSender()

@property (readonly, nonatomic) id<SSSender> inner;

@end

@implementation SSStatusCodeSender

- (instancetype)initWithInner:(id<SSSender>)inner {
    if (self = [super init]) {
        _inner = inner;
    }
    return self;
}

- (SSSmartyResponse*)sendRequest:(SSSmartyRequest*)request error:(NSError**)error {
    SSSmartyResponse *response;
    if (self.inner && [self.inner respondsToSelector:@selector(sendRequest:error:)]) {
        response = [self.inner sendRequest:request error:error];
    }

    NSDictionary *details;
    
    switch (response.statusCode) {
        case 200:
            return response;
        case 400:
            details = @{NSLocalizedDescriptionKey: @"Bad Request (Malformed Payload): A GET request lacked a street field or the request body of a POST request contained malformed JSON."};
            *error = [NSError errorWithDomain:SSErrorDomain code:BadRequestError userInfo:details];
            return nil;
        case 401:
            details = @{NSLocalizedDescriptionKey: @"Unauthorized: The credentials were provided incorrectly or did not match any existing, active credentials."};
            *error = [NSError errorWithDomain:SSErrorDomain code:BadCredentialsError userInfo:details];
            return nil;
        case 402:
            details = @{NSLocalizedDescriptionKey: @"Payment Required: There is no active subscription for the account associated with the credentials submitted with the request."};
            *error = [NSError errorWithDomain:SSErrorDomain code:PaymentRequiredError userInfo:details];
            return nil;
        case 413:
            details = @{NSLocalizedDescriptionKey: @"Request Entity Too Large: The request body has exceeded the maximum size."};
            *error = [NSError errorWithDomain:SSErrorDomain code:RequestEntityTooLargeError userInfo:details];
            return nil;
        case 422:
            details = @{NSLocalizedDescriptionKey: @"GET request lacked required fields."};
            *error = [NSError errorWithDomain:SSErrorDomain code:UnprocessableEntityError userInfo:details];
            return nil;
        case 429:
            details = @{NSLocalizedDescriptionKey: @"When using public \"website key\" authentication, we restrict the number of requests coming from a given source over too short of a time."};
            *error = [NSError errorWithDomain:SSErrorDomain code:TooManyRequestsError userInfo:details];
            return nil;
        case 500:
            details = @{NSLocalizedDescriptionKey: @"Internal Server Error."};
            *error = [NSError errorWithDomain:SSErrorDomain code:InternalServerError userInfo:details];
            return nil;
        case 503:
            details = @{NSLocalizedDescriptionKey: @"Service Unavailable. Try again later."};
            *error = [NSError errorWithDomain:SSErrorDomain code:ServiceUnavailableError userInfo:details];
            return nil;
        case 504:
            details = @{NSLocalizedDescriptionKey: @"The upstream data provider did not respond in a timely fashion and the request failed. A serious, yet rare occurrence indeed."};
            *error = [NSError errorWithDomain:SSErrorDomain code:GatewayTimeoutError userInfo:details];
            return nil;
        default:
            return nil;
    }
}

@end
