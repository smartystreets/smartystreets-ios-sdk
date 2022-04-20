import Foundation

class RetrySender: SmartySender {
    
    var maxRetries:Int
    var inner:SmartySender
    var logger:SmartyLogger
    var sleeper:SmartySleeper
    let maxBackoffDuration = 10
    
    init(maxRetries:Int, sleeper:Any, logger:Any, inner:Any) {
        self.maxRetries = maxRetries
        self.sleeper = sleeper as! SmartySleeper
        self.logger = logger as! SmartyLogger
        self.inner = inner as! SmartySender
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        for attempt in 0...self.maxRetries {
            let response:SmartyResponse! = trySendingRequest(request:request, attempts:attempt, error:&error)
            if response != nil {
                return response
            }
        }
        let details = [NSLocalizedDescriptionKey:"MaxRetries met"]
        error = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.MaxRetriesExceededError.rawValue, userInfo: details)
        return nil
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func trySendingRequest(request:SmartyRequest, attempts:Int, error: inout NSError!) -> SmartyResponse! {
        print(request.getUrl())
        let response:SmartyResponse! = self.inner.sendRequest(request: request, error: &error)
        
        if response == nil {
            backoff(attempt:attempts, error:error)
            return nil
        }
        
        if response.statusCode == 429 {
            backoff(attempt: 5, error: error)
            return nil
        }
        
        return response
    }
    
    func backoff(attempt:Int, error: NSError?) {
        let backoffDuration  = Int(min(attempt, maxBackoffDuration))
        
        let message = "There was an error processing the request. Retrying in \(backoffDuration) seconds... Error: \(error?.localizedDescription ?? "nil")"
        
        self.logger.log(message: message)
        self.sleeper.sleep(seconds: backoffDuration)
    }
}
