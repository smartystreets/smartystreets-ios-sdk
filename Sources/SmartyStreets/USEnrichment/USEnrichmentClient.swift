import Foundation

public class USEnrichmentClient: NSObject {

    private var sender:SmartySender
    private var propertyPrincipalSerializer:PropertyPrincipalSerializer
    private var geoReferenceSerializer:GeoReferenceSerializer
    private var secondarySerializer:SecondarySerializer
    private var secondaryCountSerializer:SecondaryCountSerializer
    private var businessSummarySerializer:BusinessSummarySerializer
    private var businessDetailSerializer:BusinessDetailSerializer

    init(sender:Any) {
        // It is recommended to instantiate this class using ClientBuilder.

        self.sender = sender as! SmartySender
        self.propertyPrincipalSerializer = PropertyPrincipalSerializer()
        self.geoReferenceSerializer = GeoReferenceSerializer()
        self.secondarySerializer = SecondarySerializer()
        self.secondaryCountSerializer = SecondaryCountSerializer()
        self.businessSummarySerializer = BusinessSummarySerializer()
        self.businessDetailSerializer = BusinessDetailSerializer()
    }

    public func sendPropertyPrincipalLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [PrincipalResult]? {
        let lookup = PropertyPrincipalEnrichmentLookup(smartyKey: smartyKey)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendPropertyPrincipalLookup(inputLookup: EnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> [PrincipalResult]? {
        let lookup = PropertyPrincipalEnrichmentLookup(lookup: inputLookup)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendGeoReferenceLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [GeoReferenceResult]? {
        let lookup = GeoReferenceEnrichmentLookup(smartyKey: smartyKey)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendGeoReferenceLookup(inputLookup: EnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> [GeoReferenceResult]? {
        let lookup = GeoReferenceEnrichmentLookup(lookup: inputLookup)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendSecondaryLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [SecondaryResult]? {
        let lookup = SecondaryEnrichmentLookup(smartyKey: smartyKey)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendSecondaryLookup(inputLookup: EnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> [SecondaryResult]? {
        let lookup = SecondaryEnrichmentLookup(lookup: inputLookup)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendSecondaryCountLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [SecondaryCountResult]? {
        let lookup = SecondaryCountEnrichmentLookup(smartyKey: smartyKey)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendSecondaryCountLookup(inputLookup: EnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> [SecondaryCountResult]? {
        let lookup = SecondaryCountEnrichmentLookup(lookup: inputLookup)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendBusinessLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [BusinessSummaryResult]? {
        let lookup = BusinessSummaryEnrichmentLookup(smartyKey: smartyKey)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendBusinessLookup(inputLookup: EnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> [BusinessSummaryResult]? {
        let lookup = BusinessSummaryEnrichmentLookup(lookup: inputLookup)
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendBusinessLookup(lookup: BusinessSummaryEnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> [BusinessSummaryResult]? {
        _ = sendEnrichment(lookup: lookup, error: error)
        return lookup.results
    }

    public func sendBusinessDetailLookup(businessId: String, error: UnsafeMutablePointer<NSError?>) -> BusinessDetailResult? {
        let lookup = BusinessDetailEnrichmentLookup(businessId: businessId)
        _ = sendBusinessDetail(lookup: lookup, error: error)
        return lookup.getResult()
    }

    public func sendBusinessDetailLookup(lookup: BusinessDetailEnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> BusinessDetailResult? {
        _ = sendBusinessDetail(lookup: lookup, error: error)
        return lookup.getResult()
    }

    private func sendEnrichment(lookup: EnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> Bool {
        if error.pointee != nil { return false }

        if isBlank(lookup.getSmartyKey()) && isBlank(lookup.getStreet()) && isBlank(lookup.getFreeform()) {
            let smartyErrors = SmartyErrors()
            let details = [NSLocalizedDescriptionKey: "Lookup requires one of 'smartyKey', 'street', or 'freeform' to be set"]
            error.pointee = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.FieldNotSetError.rawValue, userInfo: details)
            return false
        }

        let request = buildRequest(lookup: lookup)
        return dispatch(request: request, lookup: lookup, serializer: serializer(for: lookup), error: error)
    }

    private func sendBusinessDetail(lookup: BusinessDetailEnrichmentLookup, error: UnsafeMutablePointer<NSError?>) -> Bool {
        if error.pointee != nil { return false }

        if isBlank(lookup.getBusinessId()) {
            let smartyErrors = SmartyErrors()
            let details = [NSLocalizedDescriptionKey: "BusinessDetailEnrichmentLookup requires a non-empty 'businessId'"]
            error.pointee = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.FieldNotSetError.rawValue, userInfo: details)
            return false
        }

        let request = buildBusinessDetailRequest(lookup: lookup)
        return dispatch(request: request, lookup: lookup, serializer: self.businessDetailSerializer, error: error)
    }

    private func dispatch(request: SmartyRequest, lookup: EnrichmentLookupBase, serializer: SmartySerializer, error: UnsafeMutablePointer<NSError?>) -> Bool {
        let response = self.sender.sendRequest(request: request, error: &error.pointee)

        // Capture the server-refreshed ETag even if a 304 surfaced as NSError (the underlying
        // response is still delivered). The NotModifiedInfo NSError already carries this in
        // userInfo, but mirroring it on the lookup keeps both paths symmetric.
        if let response = response, let etag = responseEtag(from: response.headers) {
            lookup.setResponseEtag(etag: etag)
        }

        if error.pointee != nil { return false }

        if let response = response {
            lookup.deserializeAndSetResults(serializer: serializer, payload: response.payload, error: error)
        }

        return error.pointee == nil
    }

    private func serializer(for lookup: EnrichmentLookupBase) -> SmartySerializer {
        if lookup is PropertyPrincipalEnrichmentLookup {
            return self.propertyPrincipalSerializer
        } else if lookup is GeoReferenceEnrichmentLookup {
            return self.geoReferenceSerializer
        } else if lookup is SecondaryEnrichmentLookup {
            return self.secondarySerializer
        } else if lookup is SecondaryCountEnrichmentLookup {
            return self.secondaryCountSerializer
        } else if lookup is BusinessSummaryEnrichmentLookup {
            return self.businessSummarySerializer
        }
        preconditionFailure("No serializer registered for enrichment lookup type \(type(of: lookup))")
    }

    private func buildRequest(lookup:EnrichmentLookup) -> SmartyRequest {
        var request = SmartyRequest()
        if (lookup.getSmartyKey() != "") {
            if lookup.getDataSubsetName() == "" {
                request.urlComponents = "/" + lookup.getSmartyKey() + "/" + lookup.getDatasetName()
            } else {
                request.urlComponents = "/" + lookup.getSmartyKey() + "/" + lookup.getDatasetName() + "/" + lookup.getDataSubsetName()
            }
        }
        else {
            if lookup.getDataSubsetName() == "" {
                request.urlComponents = "/search/" + lookup.getDatasetName()
            } else {
                request.urlComponents = "/search/" + lookup.getDatasetName() + "/" + lookup.getDataSubsetName()
            }
        }
        request = buildParameters(request: request, lookup: lookup)
        return request
    }

    private func buildBusinessDetailRequest(lookup: BusinessDetailEnrichmentLookup) -> SmartyRequest {
        let request = SmartyRequest()
        request.urlComponents = "/business/" + businessIdPathEncoded(lookup.getBusinessId())
        applyCommonParameters(request: request, lookup: lookup)
        return request
    }

    private func buildParameters(request: SmartyRequest, lookup: EnrichmentLookup) -> SmartyRequest {
        if (lookup.getStreet() != "") {
            request.setValue(value: lookup.getStreet(), HTTPParameterField: "street")
        }
        if (lookup.getCity() != "") {
            request.setValue(value: lookup.getCity(), HTTPParameterField: "city")
        }
        if (lookup.getState() != "") {
            request.setValue(value: lookup.getState(), HTTPParameterField: "state")
        }
        if (lookup.getZipcode() != "") {
            request.setValue(value: lookup.getZipcode(), HTTPParameterField: "zipcode")
        }
        if (lookup.getFreeform() != "") {
            request.setValue(value: lookup.getFreeform(), HTTPParameterField: "freeform")
        }
        if (lookup.getFeatures() != "") {
            request.setValue(value: lookup.getFeatures(), HTTPParameterField: "features")
        }
        applyCommonParameters(request: request, lookup: lookup)
        return request
    }

    private func applyCommonParameters(request: SmartyRequest, lookup: EnrichmentLookupBase) {
        if (!lookup.getIncludeAttributes().isEmpty) {
            request.setValue(value: buildFilterString(list: lookup.getIncludeAttributes()), HTTPParameterField: "include")
        }
        if (!lookup.getExcludeAttributes().isEmpty) {
            request.setValue(value: buildFilterString(list: lookup.getExcludeAttributes()), HTTPParameterField: "exclude")
        }
        if (lookup.getRequestEtag() != "") {
            request.setValue(value: lookup.getRequestEtag(), HTTPHeaderField: "Etag")
        }
        for key in lookup.getCustomParamArray().keys {
            request.setValue(value: lookup.getCustomParamArray()[key] ?? "", HTTPParameterField: key)
        }
    }

    private func buildFilterString(list:[String]) -> String {
        if list.count == 0 {
            return String()
        }

        return list.joined(separator: ",")
    }

    private func businessIdPathEncoded(_ id: String) -> String {
        // Match .NET's Uri.EscapeDataString for path segments: percent-encode reserved chars
        // like /, ?, #, and anything not unreserved.
        var allowed = CharacterSet.urlPathAllowed
        allowed.remove(charactersIn: "/?#")
        return id.addingPercentEncoding(withAllowedCharacters: allowed) ?? id
    }

    private func isBlank(_ value: String) -> Bool {
        return value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func responseEtag(from headers: [String:String]) -> String? {
        for (key, value) in headers {
            if key.caseInsensitiveCompare("Etag") == .orderedSame {
                return value
            }
        }
        return nil
    }
}
