import Foundation

class SmartyErrors {
    let SSErrorDomain = "SmartyErrorDomain"
    
    enum SSErrors: Int {
        case BatchFullError
        case FieldNotSetError
        case ObjectNilError
        case ObjectInvalidTypeError
        case NotPositiveIntergerError
        case JSONSerializationError
        case MaxRetriesExceededError
        case BadRequestError = 400
        case BadCredentialsError = 401
        case PaymentRequiredError = 402
        case RequestEntityTooLargeError = 413
        case UnprocessableEntityError = 422
        case TooManyRequestsError = 429
        case InternalServerError = 500
        case ServiceUnavailableError = 503
        case GatewayTimeoutError = 504
    }
}
