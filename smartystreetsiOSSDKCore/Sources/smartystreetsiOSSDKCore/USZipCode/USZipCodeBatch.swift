import Foundation

public class USZipCodeBatch: SmartyBatch {
    
    override public func add(newAddress: Any, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Adds a Lookup object to the batch. Raises an exception if the batch is already full (100 Lookups).
        
        let smartyErrors = SmartyErrors()
        var addressPointer = UnsafeMutablePointer<USZipCodeLookup>.allocate(capacity: 1)
        if newAddress is USZipCodeLookup {
            addressPointer.initialize(to: newAddress as! USZipCodeLookup)
        } else {
            addressPointer = newAddress as! UnsafeMutablePointer<USZipCodeLookup>
        }
        if self.allLookups.count >= maxBatchSize {
            let details = [NSLocalizedDescriptionKey: "Batch size cannot exceed \(maxBatchSize)"]
            error.pointee = NSError(domain: smartyErrors.SSErrorDomain, code: SmartyErrors.SSErrors.BatchFullError.rawValue, userInfo: details)
            return false
        }
        
        self.allLookups.add(addressPointer.pointee)
        
        let key:String? = addressPointer.pointee.inputId
        if let key = key {
            self.namedLookups[key] = addressPointer.pointee
            return false
        } else {
            return true
        }
    }
}
