import Foundation

@objcMembers public class SmartyBatch: NSObject {
    
    let maxBatchSize = 100
    var namedLookups:[String:Any]
    var allLookups:NSMutableArray
    
    override public init() {
        self.namedLookups = [String:Any]()
        self.allLookups = NSMutableArray()
    }
    
    @objc func add(newAddress:Any, error: UnsafeMutablePointer<NSError?>) -> Bool {
        return true
    }
    
    func getLookupById(inputId:String) -> Any {
        return self.namedLookups[inputId]!
    }
    
    func getLookupAtIndex(index:Int) -> Any {
        return self.allLookups[index]
    }
    
    func count() -> Int {
        return self.allLookups.count
    }
    
    func removeAllObjects() {
        self.allLookups.removeAllObjects()
        self.namedLookups.removeAll()
    }
}
