import Foundation

public class USStreetBatch: SmartyBatch {
    
    override public func add(newAddress: Any, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Adds a Lookup object to the batch. Raises an exception if the batch is already full (100 Lookups).
        
        let smartyErrors = SmartyErrors()
        let mutableAddress = newAddress as! USStreetLookup
        if self.allLookups.count >= maxBatchSize {
            let details = [NSLocalizedDescriptionKey: "Batch size cannot exceed \(maxBatchSize)"]
            error.pointee = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.BatchFullError.rawValue, userInfo: details)
            return false
        }
        
        self.allLookups.add(mutableAddress)
        
        let key:String? = mutableAddress.inputId
        if let key = key {
            self.namedLookups[key] = mutableAddress
            return false
        } else {
            return true
        }
    }
}
