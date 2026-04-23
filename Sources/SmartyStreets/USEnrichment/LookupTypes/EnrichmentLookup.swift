import Foundation

public class EnrichmentLookup: EnrichmentLookupBase, Encodable {
    private var smarty_key: String
    private let data_set_name: String
    private let data_subset_name: String
    private var street: String
    private var city: String
    private var state: String
    private var zipcode: String
    private var freeform: String
    private var features: String

    public init(smartyKey: String, datasetName: String, dataSubsetName: String) {
        self.smarty_key = smartyKey
        self.data_set_name = datasetName
        self.data_subset_name = dataSubsetName
        self.street = ""
        self.city = ""
        self.state = ""
        self.zipcode = ""
        self.freeform = ""
        self.features = ""
        super.init()
    }

    public override init() {
        self.smarty_key = ""
        self.data_set_name = ""
        self.data_subset_name = ""
        self.street = ""
        self.city = ""
        self.state = ""
        self.zipcode = ""
        self.freeform = ""
        self.features = ""
        super.init()
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

    public func getFeatures() -> String {
        return self.features
    }

    // Deprecated: prefer getRequestEtag/setRequestEtag. Kept as an alias on the request etag
    // so callers migrating from earlier SDK versions keep working unchanged.
    public func getEtag() -> String {
        return self.getRequestEtag()
    }

    public func setEtag(etag: String) {
        self.setRequestEtag(etag: etag)
    }

    public func setSmartyKey(smarty_key: String) {
        self.smarty_key = smarty_key
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

    public func setFeatures(features: String) {
        self.features = features
    }

    // Encodable — preserves the pre-split JSON shape so existing test fixtures keep working.
    // The response_etag is deliberately excluded: it is server-populated, not part of the request.
    private enum CodingKeys: String, CodingKey {
        case smarty_key
        case data_set_name
        case data_subset_name
        case street
        case city
        case state
        case zipcode
        case freeform
        case features
        case etag
        case include_array
        case exclude_array
        case custom_param_array
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.smarty_key, forKey: .smarty_key)
        try container.encode(self.data_set_name, forKey: .data_set_name)
        try container.encode(self.data_subset_name, forKey: .data_subset_name)
        try container.encode(self.street, forKey: .street)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.state, forKey: .state)
        try container.encode(self.zipcode, forKey: .zipcode)
        try container.encode(self.freeform, forKey: .freeform)
        try container.encode(self.features, forKey: .features)
        try container.encode(self.getRequestEtag(), forKey: .etag)
        try container.encode(self.getIncludeAttributes(), forKey: .include_array)
        try container.encode(self.getExcludeAttributes(), forKey: .exclude_array)
        try container.encode(self.getCustomParamArray(), forKey: .custom_param_array)
    }
}
