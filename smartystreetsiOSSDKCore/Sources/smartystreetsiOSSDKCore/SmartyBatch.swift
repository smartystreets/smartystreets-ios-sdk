import Foundation

@objcMembers public class SmartyBatch: NSObject {
    
    let maxBatchSize = 100
    public var namedLookups:[String:Any]
    public var allLookups:NSMutableArray
    
    override public init() {
        self.namedLookups = [String:Any]()
        self.allLookups = NSMutableArray()
    }
    
    @objc func add(newAddress:Any, error: UnsafeMutablePointer<NSError?>) -> Bool {
        return true
    }
    
    public func getLookupById(inputId:String) -> Any {
        return self.namedLookups[inputId]!
    }
    
    public func getLookupAtIndex(index:Int) -> Any {
        return self.allLookups[index]
    }
    
    public func count() -> Int {
        return self.allLookups.count
    }
    
    func removeAllObjects() {
        self.allLookups.removeAllObjects()
        self.namedLookups.removeAll()
    }
}
