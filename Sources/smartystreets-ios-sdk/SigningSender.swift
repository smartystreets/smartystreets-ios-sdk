import Foundation

class SigningSender: SmartySender {
    
    var signer:SmartyCredentials
    var inner:SmartySender
    
    init(signer:SmartyCredentials, inner:Any) {
        self.signer = signer
        self.inner = inner as! SmartySender
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.signer.sign(request: request)
        
        return self.inner.sendRequest(request: request, error: &error)
    }
}
