import Foundation

public class SmartySender: NSObject {
    func sendRequest(request:SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        let details = [NSLocalizedDescriptionKey:"No sender specified"]
        error = NSError(domain: SmartyErrors().SSErrorDomain, code: 200, userInfo: details)
        return nil
    }
}
