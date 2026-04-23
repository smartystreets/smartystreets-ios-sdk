import Foundation

class SmartyErrors {
    let SSErrorDomain = "SmartyErrorDomain"

    // userInfo key on a NotModifiedInfo NSError carrying the server-refreshed Etag header value.
    static let ResponseEtagKey = "SSResponseEtag"

    enum SSErrors: Int {
        case BatchFullError
        case FieldNotSetError
        case ObjectNilError
        case ObjectInvalidTypeError
        case NotPositiveIntergerError
        case JSONSerializationError
        case MaxRetriesExceededError
        case BusinessDetailMultipleResultsError
        case NotModifiedInfo = 304
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
