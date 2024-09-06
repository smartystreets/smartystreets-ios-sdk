import Foundation


public class SecondaryCountSerializer: SmartySerializer {
    override func Serialize(obj: Any?, error: inout NSError!) -> Data! {
        let raw:SecondaryCountEnrichmentLookup? = obj as? SecondaryCountEnrichmentLookup
        let smartyErrors = SmartyErrors()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        if raw == nil {
            let details = [NSLocalizedDescriptionKey: "The object to be serialized is nil"]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ObjectNilError.rawValue, userInfo: details)
            return nil
        }
        
        do {
            let jsonData = try jsonEncoder.encode(raw) as Data
            return jsonData
        } catch let jsonError {
            let details = [NSLocalizedDescriptionKey: jsonError.localizedDescription]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ObjectInvalidTypeError.rawValue, userInfo: details)
        }
        
        
        return nil
    }
    
    override public func Deserialize(payload: Data?, error: inout NSError!) -> Any! {
        let smartyErrors = SmartyErrors()
        let jsonDecoder = JSONDecoder()
        if payload == nil {
            let details = [NSLocalizedDescriptionKey: "The payload is nil."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ObjectNilError.rawValue, userInfo: details)
            return nil
        }
        
        do {
            let result:[SecondaryCountResult] = try jsonDecoder.decode([SecondaryCountResult].self, from: payload!)
            return result
        } catch let jsonError {
            let details = [NSLocalizedDescriptionKey:jsonError.localizedDescription]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ObjectInvalidTypeError.rawValue, userInfo: details)
            return nil
        }
    }
}
