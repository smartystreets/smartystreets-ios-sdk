import Foundation

public class EnrichmentLookup: Encodable {
    private var smarty_key: String
    private let data_set_name: String
    private let data_subset_name: String
    private var include_array: [String]
    private var exclude_array: [String]
    private var street: String
    private var city: String
    private var state: String
    private var zipcode: String
    private var freeform: String
    private var etag: String
    private var custom_param_array: [String: String] = [:]

    public init(smartyKey: String, datasetName: String, dataSubsetName: String) {
        self.smarty_key = smartyKey
        self.data_set_name = datasetName
        self.data_subset_name = dataSubsetName
        self.include_array = [String]()
        self.exclude_array = [String]()
        self.street = ""
        self.city = ""
        self.state = ""
        self.zipcode = ""
        self.freeform = ""
        self.etag = ""
    }
    
    public init() {
        self.smarty_key = ""
        self.data_set_name = ""
        self.data_subset_name = ""
        self.include_array = [String]()
        self.exclude_array = [String]()
        self.street = ""
        self.city = ""
        self.state = ""
        self.zipcode = ""
        self.freeform = ""
        self.etag = ""
    }

    public func getSmartyKey() -> String {
        return smarty_key
    }

    public func getDatasetName() -> String {
        return data_set_name
    }

    public func getDataSubsetName() -> String {
        return data_subset_name
    }
    
    public func getIncludeAttributes() -> [String] {
        return self.include_array
    }
    
    public func getExcludeAttributes() -> [String] {
        return self.exclude_array
    }
    
    public func getStreet() -> String {
        return self.street
    }
    
    public func getCity() -> String {
        return self.city
    }
    
    public func getState() -> String {
        return self.state
    }
    
    public func getZipcode() -> String {
        return self.zipcode
    }
    
    public func getFreeform() -> String {
        return self.freeform
    }
    
    public func getEtag() -> String{
        return self.etag
    }
    
    public func getCustomParamArray() -> [String: String] {
        return self.custom_param_array
    }
    
    public func setSmartyKey(smarty_key: String) {
        self.smarty_key = smarty_key
    }
    
    public func addIncludeAttribute(attribute: String) {
        self.include_array.append(attribute)
    }
    
    public func addExcludeAttribute(attribute: String) {
        self.exclude_array.append(attribute)
    }
    
    public func setStreet(street: String) {
        self.street = street
    }
    
    public func setCity(city: String) {
        self.city = city
    }
    
    public func setState(state: String) {
        self.state = state
    }
    
    public func setZipcode(zipcode: String) {
        self.zipcode = zipcode
    }
    
    public func setFreeform(freeform: String) {
        self.freeform = freeform
    }
    
    public func setEtag(etag: String) {
        self.etag = etag
    }
    
    public func addCustomParameter(parameter: String, value: String) {
        self.custom_param_array.updateValue(value, forKey: parameter)
    }

    public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        fatalError("You must use a Lookup subclass with an implemented version of deserializeAndSetResults")
    }
}
