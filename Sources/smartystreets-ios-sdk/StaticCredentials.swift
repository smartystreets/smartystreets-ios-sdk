import Foundation

class StaticCredentials: SmartyCredentials {
    
    var authId:String
    var authToken:String
    
    init(authId:String, authToken:String) {
        self.authId = authId
        self.authToken = authToken
    }
    
    override func sign(request:SmartyRequest) {
        request.setValue(value: self.authId, HTTPParameterField: "auth-id")
        request.setValue(value: self.authToken, HTTPParameterField: "auth-token")
    }
}
