import Foundation

class SharedCredentials: SmartyCredentials {
    
    var id:String
    var hostname:String
    
    init(id: String, hostname: String) {
        self.id = id
        self.hostname = hostname
    }
    
    override func sign(request:SmartyRequest) {
        request.setValue(value: self.id, HTTPParameterField: "key")
        
        let fullHostname = "https://\(self.hostname)"
        request.setValue(value: fullHostname, HTTPHeaderField: "Referer")
    }
}
