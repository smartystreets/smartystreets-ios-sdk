import Foundation

class USExtractSerializer: SmartySerializer {
    override func Serialize(obj: Any?, error: inout NSError!) -> Data! {
        let raw:[USExtractLookup]? = obj as? [USExtractLookup]
        let smartyErrors = SmartyErrors()
        let jsonEncoder = JSONEncoder()
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
}
