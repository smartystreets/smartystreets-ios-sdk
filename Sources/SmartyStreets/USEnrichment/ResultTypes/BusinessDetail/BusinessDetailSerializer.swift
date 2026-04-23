import Foundation

public class BusinessDetailSerializer: SmartySerializer {
    // Serialize is unused: the business detail endpoint is GET-only, so we inherit the base no-op.

    override public func Deserialize(payload: Data?, error: inout NSError!) -> Any! {
        let smartyErrors = SmartyErrors()
        let jsonDecoder = JSONDecoder()
        if payload == nil {
            let details = [NSLocalizedDescriptionKey: "The payload is nil."]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ObjectNilError.rawValue, userInfo: details)
            return nil
        }

        do {
            let result:[BusinessDetailResult] = try jsonDecoder.decode([BusinessDetailResult].self, from: payload!)
            return result
        } catch let jsonError {
            let details = [NSLocalizedDescriptionKey:jsonError.localizedDescription]
            error = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.ObjectInvalidTypeError.rawValue, userInfo: details)
            return nil
        }
    }
}
