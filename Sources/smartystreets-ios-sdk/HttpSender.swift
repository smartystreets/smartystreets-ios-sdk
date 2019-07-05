import Foundation

extension URLSession {
    func synchronousDataTask(urlrequest: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: urlrequest) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}

class HttpSender: SmartySender {
    var maxTimeout:Int
    var debug:Bool
    var proxy:NSDictionary?
    var myResponse = SmartyResponse(statusCode: 0, payload: Data())
    
    override init() {
        self.maxTimeout = 100
        self.debug = false
    }
    
    init(maxTimeout:Int!, proxy:NSDictionary!, debug:Bool!) {
        self.maxTimeout = maxTimeout
        self.proxy = proxy
        self.debug = debug
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        var httpRequest = buildHttpRequest(request:request)
        var response:SmartyResponse! = nil
        copyHeaders(request: request, httpRequest: &httpRequest)
        do {
            response = try buildResponse(httpRequest: httpRequest)
        } catch let buildError {
            error = buildError as NSError
        }
        if error != nil {
            response.statusCode = 200
        }
        return response
    }
    
    func buildHttpRequest(request:SmartyRequest) -> URLRequest {
        let url = URL(string: request.getUrl())
        var httpRequest = URLRequest(url: url!)
        if request.method == "GET" {
            httpRequest.httpMethod = "GET"
        } else {
            httpRequest.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            httpRequest.setValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")
            httpRequest.httpMethod = "POST"
            httpRequest.httpBody = request.payload
        }
        return httpRequest
    }
    
    func copyHeaders(request:SmartyRequest, httpRequest: inout URLRequest) {
        for item in request.headers {
            httpRequest.addValue(item.value, forHTTPHeaderField: item.key)
        }
        
        let version = Version().version
        let userAgent = "smartystreets (sdk:ios@\(version))"
        
        httpRequest.addValue(userAgent, forHTTPHeaderField: "User-Agent")
    }
    
    func buildResponse(httpRequest:URLRequest) throws -> SmartyResponse! {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.connectionProxyDictionary = self.proxy as? [AnyHashable : Any]
        
        configuration.timeoutIntervalForRequest = Double(self.maxTimeout)
        
        let session = URLSession(configuration: configuration)
        
        let (data, response, error) = session.synchronousDataTask(urlrequest: httpRequest)
        if let error = error {
            NSLog("An error occurred in sending the request: \(error)")
            throw error
        }
        
        if response == nil {
            return nil
        }
        
        let httpResponse = response as! HTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if self.debug {
            self.logHttpRequest(httpRequest: httpRequest, response: httpResponse, payload: data!)
        }
        self.myResponse = SmartyResponse(statusCode: statusCode, payload: data!)
        
        return self.myResponse
    }
    
    func logHttpRequest(httpRequest:URLRequest, response: HTTPURLResponse, payload:Data) {
        var message = String()
        message.append("\n***Request***\n")
        message.append("\nMethod: \(httpRequest.httpMethod!)\n")
        message.append("\nURL: \(httpRequest.url!)\n")
        message.append("\nHeaders: \(httpRequest.allHTTPHeaderFields!)\n")
        message.append("\nRequest body: \n \(httpRequest.httpBody!)\n")
        
        message.append("\n***Response***\n")
        message.append("\nHeaders:\n \(response.allHeaderFields)\n")
        message.append("\nStatus: \(response.statusCode)")
        message.append("\nBody: \n\(payload)")
    }
}
