import Foundation
@testable import smartystreetsiOSSDKCore

class MockSerializer: SmartySerializer {
    
    var bytes:Data?
    var result:Any?
    
    override init() {   }
    
    init(bytes:Data) {
        self.bytes = bytes
    }
    
    init(result:Any) {
        self.result = result
    }
    
    override func Serialize(obj: Any?, error: inout NSError!) -> Data! {
        return self.bytes
    }
    
    override func Deserialize(payload: Data?, error: inout NSError!) -> Any! {
        return self.result
    }
}
