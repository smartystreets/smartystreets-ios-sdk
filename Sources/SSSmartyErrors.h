#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const SSErrorDomain;

typedef NS_ENUM(NSInteger, SSErrors) {
    BatchFullError,
    ObjectNilError,
    ObjectInvalidTypeError,
    MaxCandidatesNotPositiveIntegerError,
    BadRequestError = 400,
    BadCredentialsError = 401,
    PaymentRequiredError = 402,
    RequestEntityTooLargeError = 413,
    TooManyRequestsError = 429,
    InternalServerError = 500,
    ServiceUnavailableError = 503
};

//@end
