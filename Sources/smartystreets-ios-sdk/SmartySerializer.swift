import Foundation

public class SmartySerializer: NSObject {
    func Serialize(obj: Any?, error: inout NSError!) -> Data! {
        return Data()
    }
    
    func Deserialize(payload: Data?, error: inout NSError!) -> Any! {
        let smartyErrors = SmartyErrors()
        if payload == nil {
            let details = [NSLocalizedDescriptionKey: "The payload is nil."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ObjectNilError.rawValue, userInfo: details)
            return nil
        }
        
        do {
            let result = try JSONSerialization.jsonObject(with: payload!, options: []) as? [String:Any]
            return result
        } catch let jsonError {
            let details = [NSLocalizedDescriptionKey:jsonError.localizedDescription]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ObjectInvalidTypeError.rawValue, userInfo: details)
            return nil
        }
    }
}
