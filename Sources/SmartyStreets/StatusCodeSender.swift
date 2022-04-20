import Foundation

class StatusCodeSender: SmartySender {
    
    var inner: SmartySender
    
    init(inner:Any) {
        self.inner = inner as! SmartySender
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        let response = self.inner.sendRequest(request: request, error: &error)
        let smartyErrors = SmartyErrors()
        
        switch response?.statusCode {
        case 200:
            return response
        case 400:
            let details = [NSLocalizedDescriptionKey:"Bad Request (Malformed Payload): A GET request lacked a street field or the request body of a POST request contained malformed JSON."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.BadRequestError.rawValue, userInfo: details)
            return nil
        case 401:
            let details = [NSLocalizedDescriptionKey:"Unauthorized: The credentials were provided incorrectly or did not match any existing, active credentials."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.BadCredentialsError.rawValue, userInfo: details)
            return nil
        case 402:
            let details = [NSLocalizedDescriptionKey:"Payment Required: There is no active subscription for the account associated with the credentials submitted with the request."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.PaymentRequiredError.rawValue, userInfo: details)
            return nil
        case 413:
            let details = [NSLocalizedDescriptionKey:"Request Entity Too Large: The request body has exceeded the maximum size."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.RequestEntityTooLargeError.rawValue, userInfo: details)
            return nil
        case 422:
            let details = [NSLocalizedDescriptionKey:"GET request lacked required fields."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.UnprocessableEntityError.rawValue, userInfo: details)
            return nil
        case 429:
            let details = [NSLocalizedDescriptionKey:"When using public \"website key\" authentication, we restrict the number of requests coming from a given source over too short of a time."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.TooManyRequestsError.rawValue, userInfo: details)
            return response
        case 500:
            let details = [NSLocalizedDescriptionKey:"Internal Server Error."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.InternalServerError.rawValue, userInfo: details)
            return nil
        case 503:
            let details = [NSLocalizedDescriptionKey:"Service Unavailable. Try again later."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ServiceUnavailableError.rawValue, userInfo: details)
            return nil
        case 504:
            let details = [NSLocalizedDescriptionKey:"The upstream data provider did not respond in a timely fashion and the request failed. A serious, yet rare occurrence indeed."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.GatewayTimeoutError.rawValue, userInfo: details)
            return nil
        default:
            return nil
        }
    }
}
