#import <Foundation/Foundation.h>

//@implementation SmartyErrors

FOUNDATION_EXPORT NSString *const SSErrorDomain = @"com.smartystreets.Smartystreets_iOS_SDK.ErrorDomain";

typedef NS_ENUM(NSInteger, SSErrors) {
    BadCredentialsException,
    BadRequestException,
    BatchFullException,
    InternalServerErrorException,
    PaymentRequiredException,
    RequestEntityTooLargeException,
    ServiceUnavailableException,
    TooManyRequestsException
};

//@end