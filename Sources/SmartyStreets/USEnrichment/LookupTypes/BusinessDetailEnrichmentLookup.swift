import Foundation

public class BusinessDetailEnrichmentLookup: EnrichmentLookupBase {

    private var business_id: String
    public var result: BusinessDetailResult?

    public init(businessId: String) {
        self.business_id = businessId
        self.result = nil
        super.init()
    }

    public func getBusinessId() -> String {
        return self.business_id
    }

    public func setBusinessId(businessId: String) {
        self.business_id = businessId
    }

    public func getResult() -> BusinessDetailResult? {
        return self.result
    }

    // The business detail endpoint returns a one-element array on success. More than one element
    // is a server-contract violation; surface it as an error so callers don't silently mis-index.
    override public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        let results = serializer.Deserialize(payload: payload, error: &error.pointee) as? [BusinessDetailResult]
        guard error.pointee == nil else { return }
        if let results = results {
            if results.count > 1 {
                let smartyErrors = SmartyErrors()
                let details = [NSLocalizedDescriptionKey: "business detail response contained \(results.count) results; expected at most 1"]
                error.pointee = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.BusinessDetailMultipleResultsError.rawValue, userInfo: details)
                self.result = nil
                return
            }
            self.result = results.first
        } else {
            self.result = nil
        }
    }
}
