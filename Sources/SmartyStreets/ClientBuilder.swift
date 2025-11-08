import Foundation

@objcMembers public class ClientBuilder: NSObject {
    //    The ClientBuilder class helps you build a client object for one of the supported SmartyStreets APIs.
    //    You can use ClientBuilder's methods to customize settings like maximum retries or timeout duration.
    //    These methods are chainable, so you can usually get set up with one line of code.
    
    var signer:SmartyCredentials!
    var serializer:SmartySerializer
    var sender:SmartySender!
    var maxRetries:Int = 5
    var maxTimeout:Int = 10000
    var debug:Bool = false
    var urlPrefix:String!
    var proxy:NSDictionary!
    var licenses:[String] = []
    var queries:[String:String] = [:]
    var internationalStreetApiURL:String = "https://international-street.api.smarty.com/verify"
    var internationalAutocompleteApiURL:String = "https://international-autocomplete.api.smarty.com/v2/lookup"
    var internationalPostalCodeApiURL:String = "https://international-postal-code.api.smarty.com/lookup"
    var usAutocompleteProApiURL:String = "https://us-autocomplete-pro.api.smarty.com/lookup"
    var usExtractApiURL:String = "https://us-extract.api.smarty.com"
    var usStreetApiURL:String = "https://us-street.api.smarty.com/street-address"
    var usZipCodeApiURL:String = "https://us-zipcode.api.smarty.com/lookup"
    var usReverseGeoApiURL:String = "https://us-reverse-geo.api.smarty.com/lookup"
    var usEnrichemntApiURL:String = "https://us-enrichment.api.smarty.com/lookup"
    
    override init() {
        self.serializer = SmartySerializer()
    }
    
    public init(signer:SmartyCredentials) {
        self.signer = signer
        self.serializer = SmartySerializer()
    }
    
    public init(authId:String, authToken:String) {
        self.signer = StaticCredentials(authId: authId, authToken: authToken)
        self.serializer = SmartySerializer()
    }
    
    public init(id:String, hostname:String) {
        self.signer = SharedCredentials(id: id, hostname: hostname)
        self.serializer = SmartySerializer()
    }
    
    public func retryAtMost(maxRetries:Int) -> ClientBuilder {
        //        Sets the maximum number of times to retry sending the request to the API. (Default is 5)
        //
        //        Returns self to accommodate method chaining.
        
        self.maxRetries = maxRetries
        return self
    }
    
    public func withMaxTimeout(maxTimeout:Int) -> ClientBuilder {
        //        The maximum time (in milliseconds) to wait for a connection, and also to wait for
        //        the response to be read. (Default is 10000)
        //
        //        Returns self to accommodate method chaining.
        
        self.maxTimeout = maxTimeout
        return self
    }
    
    public func withSender(sender:SmartySender) -> ClientBuilder {
        //        Default is a series of nested senders.
        //
        //        Returns self to accommodate method chaining.
        
        self.sender = sender
        return self
    }
    
    public func withSerializer(serializer:USZipCodeSerializer) -> ClientBuilder {
        //        Changes the Serializer from the default.
        //
        //        Returns self to accommodate method chaining.
        
        self.serializer = serializer
        return self
    }
    
    public func withUrl(urlPrefix:String) -> ClientBuilder {
        //        This may be useful when using a local installation of the SmartyStreets APIs.
        //        Url is a string that defaults to the URL for the API corresponding to the Client object being built.
        //
        //        Returns self to accommodate method chaining.
        
        self.urlPrefix = urlPrefix
        return self
    }
    
    public func withProxy(host:String, port:Int) -> ClientBuilder {
        //        Assigns a proxy through which to send all Lookups.
        
        //        Returns self to accommodate method chaining.
        
        self.proxy = [kCFNetworkProxiesHTTPEnable:1, kCFNetworkProxiesHTTPProxy: host, kCFNetworkProxiesHTTPPort: port]
        return self
    }
    
    public func withDebug() -> ClientBuilder {
        //        Enables debug mode, which will print information about the HTTP request and response to the console.
        //
        //        Returns self to accommodate method chaining.
        
        self.debug = true
        return self
    }
    
    public func withLicenses(licenses:[String]) -> ClientBuilder {
        //         Allows caller to set licenses (aka "tracks")
        //
        //         Returns self to accommodate method chaining.
        
        self.licenses.append(contentsOf: licenses)
        return self
    }

    public func withCustomQuery(key:String, value:String) -> ClientBuilder {
        //         Allows caller to set custom query key value pairs
        //
        //         Returns self to accommodate method chaining.
        self.queries[key] = value
        return self
    }

    public func withCustomCommaSeparatedQuery(key:String, value:String) -> ClientBuilder {
        //         Allows caller to set custom query key value pairs, appends new values to 
        //         existing key value pairs separated by comma 
        //
        //         Returns self to accommodate method chaining.
        if let current = self.queries[key] {
            self.queries[key] = current + "," + value
        } else {
            self.queries[key] = value
        }
        return self
    }

        public func withFeatureComponentAnalysis() -> ClientBuilder {
        //         Adds to the request query to use the component analysis feature.
        //
        //         Returns self to accommodate method chaining.
        return self.withCustomCommaSeparatedQuery(key:"features",value:"component-analysis")
    }
    
    public func buildUsStreetApiClient() -> USStreetClient {
        ensureURLPrefixNotNil(url: self.usStreetApiURL)
        let serializer = USStreetSerializer()
        return USStreetClient(sender: buildSender(), serializer: serializer)
    }
    
    public func buildUsZIPCodeApiClient() -> USZipCodeClient {
        ensureURLPrefixNotNil(url: self.usZipCodeApiURL)
        let serializer = USZipCodeSerializer()
        return USZipCodeClient(sender:buildSender(), serializer: serializer)
    }
    
    public func buildInternationalStreetApiClient() -> InternationalStreetClient {
        ensureURLPrefixNotNil(url: self.internationalStreetApiURL)
        let serializer = InternationalStreetSerializer()
        return InternationalStreetClient(sender:buildSender(), serializer: serializer)
    }

    public func buildInternationalAutocompleteApiClient() -> InternationalAutocompleteClient {
        ensureURLPrefixNotNil(url: self.internationalAutocompleteApiURL)
        let serializer = InternationalAutocompleteSerializer()
        return InternationalAutocompleteClient(sender:buildSender(), serializer:serializer)
    }
    
    public func buildInternationalPostalCodeApiClient() -> InternationalPostalCodeClient {
        ensureURLPrefixNotNil(url: self.internationalPostalCodeApiURL)
        let serializer = InternationalPostalCodeSerializer()
        return InternationalPostalCodeClient(sender: buildSender(), serializer: serializer)
    }
    
    public func buildUSAutocompleteProApiClient() -> USAutocompleteProClient {
       ensureURLPrefixNotNil(url: self.usAutocompleteProApiURL)
       let serializer = USAutocompleteProSerializer()
       return USAutocompleteProClient(sender: buildSender(), serializer: serializer)
    }
    
    public func buildUsExtractApiClient() -> USExtractClient {
        ensureURLPrefixNotNil(url: self.usExtractApiURL)
        let serializer = USExtractSerializer()
        return USExtractClient(sender: buildSender(), serializer: serializer)
    }
    
    public func buildUsReverseGeoApiClient() -> USReverseGeoClient {
        ensureURLPrefixNotNil(url: self.usReverseGeoApiURL)
        let serializer = USReverseGeoSerializer()
        return USReverseGeoClient(sender: buildSender(), serializer: serializer)
    }
    
    public func buildUsEnrichmentApiClient() -> USEnrichmentClient {
        ensureURLPrefixNotNil(url: self.usEnrichemntApiURL)
        return USEnrichmentClient(sender: buildSender())
    }
    
    func buildSender() -> SmartySender {
        if let httpSender = self.sender {
            return httpSender
        }
        
        var httpSender:SmartySender = HttpSender(maxTimeout: self.maxTimeout, proxy: self.proxy, debug: self.debug)
        httpSender = StatusCodeSender(inner: httpSender)
        
        if self.maxRetries > 0 {
            httpSender = RetrySender(maxRetries: self.maxRetries, sleeper: SmartySleeper(), logger: SmartyLogger(), inner: httpSender)
        }
        
        if let httpSigner = self.signer {
            httpSender = SigningSender(signer: httpSigner, inner: httpSender)
        }
        
        httpSender = URLPrefixSender(urlPrefix: self.urlPrefix, inner: httpSender)
        
        httpSender = LicenseSender(licenses: self.licenses, inner: httpSender)
        
        httpSender = CustomQuerySender(queries: self.queries, inner: httpSender)

        return httpSender
    }
    
    func ensureURLPrefixNotNil(url:String) {
        if self.urlPrefix == nil {
            self.urlPrefix = url
        }
    }
}
