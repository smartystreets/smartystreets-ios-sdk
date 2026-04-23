import Foundation

public class EnrichmentLookupBase {
    private var include_array: [String]
    private var exclude_array: [String]
    private var request_etag: String
    private var response_etag: String
    private var custom_param_array: [String: String] = [:]

    public init() {
        self.include_array = [String]()
        self.exclude_array = [String]()
        self.request_etag = ""
        self.response_etag = ""
    }

    public func getIncludeAttributes() -> [String] {
        return self.include_array
    }

    public func addIncludeAttribute(attribute: String) {
        self.include_array.append(attribute)
    }

    public func getExcludeAttributes() -> [String] {
        return self.exclude_array
    }

    public func addExcludeAttribute(attribute: String) {
        self.exclude_array.append(attribute)
    }

    public func getRequestEtag() -> String {
        return self.request_etag
    }

    public func setRequestEtag(etag: String) {
        self.request_etag = etag
    }

    public func getResponseEtag() -> String {
        return self.response_etag
    }

    public func setResponseEtag(etag: String) {
        self.response_etag = etag
    }

    public func getCustomParamArray() -> [String: String] {
        return self.custom_param_array
    }

    public func addCustomParameter(parameter: String, value: String) {
        self.custom_param_array.updateValue(value, forKey: parameter)
    }

    public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        fatalError("You must use a Lookup subclass with an implemented version of deserializeAndSetResults")
    }
}
