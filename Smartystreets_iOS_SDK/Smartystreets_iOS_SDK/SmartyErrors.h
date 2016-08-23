#import <Foundation/Foundation.h>

//@implementation SmartyErrors

FOUNDATION_EXPORT NSString *const SSErrorDomain;
//FOUNDATION_EXPORT NSString *const SSErrorDomain = @"com.smartystreets.Smartystreets_iOS_SDK.ErrorDomain";

typedef NS_ENUM(NSInteger, SSErrors) {
    BatchFullError,
    BadRequestError = 400,
    BadCredentialsError = 401,
    PaymentRequiredError = 402,
    RequestEntityTooLargeError = 413,
    TooManyRequestsError = 429,
    InternalServerError = 500,
    ServiceUnavailableError = 503
};

//@end