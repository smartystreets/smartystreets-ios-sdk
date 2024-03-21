import Foundation

public class SmartyRequest {
    
    public var headers:[String:String]
    public var parameters:[String:String]
    public var urlPrefix:String
    public var urlComponents:String
    public var payload:Data?
    public var referer:String?
    public var method:String
    public var contentType:String
    
    init() {
        self.headers = NSMutableDictionary() as! [String : String]
        self.parameters = NSMutableDictionary() as! [String : String]
        self.urlPrefix = ""
        self.urlComponents = ""
        self.payload = nil
        self.referer = nil
        self.method = "GET"
        self.contentType = "application/json"
    }
    
    func setValue(value: String, HTTPHeaderField name:String) {
        self.headers[name] = value
    }
    
    func setValue(value: String, HTTPParameterField name: String) {
        if value == "" || name == "" {
            return
        }
        
        self.parameters[name] = value
    }
    
    public func getUrl() -> String {
        var url = self.urlPrefix
        
        if !url.contains("?") {
            url.append("?")
        }
        
        for item in self.parameters {
            if !url.hasSuffix("?") {
                url.append("&")
            }
            
            let encodedName = urlEncode(value: item.key)
            let encodedValue = urlEncode(value: item.value)
            url.append(encodedName)
            url.append("=")
            url.append(encodedValue)
        }
        return url
    }
    
    func urlEncode(value: String) -> String {
        var allowedCharacters = CharacterSet.urlPathAllowed
        allowedCharacters.remove(charactersIn: USAutocompleteProClient.arrayItemsSeparator)
        return value.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
    }
    
    func setPayload(payload:Data) {
        self.method = "POST"
        self.payload = payload
    }
}
