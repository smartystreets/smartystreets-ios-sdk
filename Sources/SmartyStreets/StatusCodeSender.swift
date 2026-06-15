import Foundation

struct ResponseErrors : Codable {
    let errors: [ResponseError]
}

struct ResponseError : Codable {
    let id: Int?
    let message: String?
}

class StatusCodeSender: SmartySender {
    
    var inner: SmartySender
    var jsonDecoder: JSONDecoder
    
    init(inner:Any) {
        self.inner = inner as! SmartySender
        self.jsonDecoder = JSONDecoder()
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        let response = self.inner.sendRequest(request: request, error: &error)
        let smartyErrors = SmartyErrors()
        
        switch response?.statusCode {
        case 200, 304:
            return response
        case 400:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Bad Request (Malformed Payload): A GET request lacked a required field or the request body of a POST request contained malformed JSON.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.BadRequestError.rawValue, userInfo: details)
            return nil
        case 401:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Unauthorized: The credentials were provided incorrectly or did not match any existing, active credentials.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.BadCredentialsError.rawValue, userInfo: details)
            return nil
        case 402:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Payment Required: There is no active subscription for the account associated with the credentials submitted with the request.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.PaymentRequiredError.rawValue, userInfo: details)
            return nil
        case 403:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Forbidden: The request contained valid data and was understood by the server, but the server is refusing action.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ForbiddenError.rawValue, userInfo: details)
            return nil
        case 408:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Request timeout error.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.RequestTimeoutError.rawValue, userInfo: details)
            return nil
        case 413:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Request Entity Too Large: The request body has exceeded the maximum size.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.RequestEntityTooLargeError.rawValue, userInfo: details)
            return nil
        case 422:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "GET request lacked required fields.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.UnprocessableEntityError.rawValue, userInfo: details)
            return nil
        case 429:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Too Many Requests: The rate limit for your account has been exceeded.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.TooManyRequestsError.rawValue, userInfo: details)
            return response
        case 500:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Internal Server Error.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.InternalServerError.rawValue, userInfo: details)
            return nil
        case 502:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Bad Gateway error.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.BadGatewayError.rawValue, userInfo: details)
            return nil
        case 503:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "Service Unavailable. Try again later.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ServiceUnavailableError.rawValue, userInfo: details)
            return nil
        case 504:
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response!, fallback: "The upstream data provider did not respond in a timely fashion and the request failed. A serious, yet rare occurrence indeed.")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.GatewayTimeoutError.rawValue, userInfo: details)
            return nil
        default:
            guard let response = response else { return nil }
            let details = [NSLocalizedDescriptionKey:messageFrom(response: response, fallback: "The server returned an unexpected HTTP status code: \(response.statusCode)")]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: response.statusCode, userInfo: details)
            return nil
        }
    }

    private func messageFrom(response: SmartyResponse, fallback: String) -> String {
        if let errors = try? self.jsonDecoder.decode(ResponseErrors.self, from: response.payload) {
            let message = errors.errors.compactMap { $0.message }.filter { !$0.isEmpty }.joined(separator: " ")
            if !message.isEmpty {
                return message
            }
        }
        let body = String(data: response.payload, encoding: .utf8)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return (fallback + " Body: " + body).trimmingCharacters(in: .whitespaces)
    }

}
