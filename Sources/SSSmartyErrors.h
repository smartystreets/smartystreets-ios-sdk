#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const SSErrorDomain;

typedef NS_ENUM(NSInteger, SSErrors) {
    BatchFullError,
    FieldNotSetError,
    ObjectNilError,
    ObjectInvalidTypeError,
    NotPositiveIntegerError,
    BadRequestError = 400,
    BadCredentialsError = 401,
    PaymentRequiredError = 402,
    RequestEntityTooLargeError = 413,
    UnprocessableEntityError = 422,
    TooManyRequestsError = 429,
    InternalServerError = 500,
    ServiceUnavailableError = 503,
    GatewayTimeoutError = 504
};

//@end
