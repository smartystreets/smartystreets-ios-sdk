import Foundation
import Smartystreets_iOS_SDK

class USStreetLookupsWithMatchStrategyExamples {
    func run() -> String {
        let client = SSStreetClientBuilder(authId: MyCredentials.AuthId,
                                            authToken: MyCredentials.AuthToken).build()
        
        let batch = SSStreetBatch()
        
        let addressWithStrictStrategy = SSStreetLookup()
        addressWithStrictStrategy.street = "691 W 1150 S"
        addressWithStrictStrategy.city = "provo"
        addressWithStrictStrategy.state = "utah"
        addressWithStrictStrategy.matchStrategy = kSSStrict
        
        let addressWithRangeStrategy = SSStreetLookup()
        addressWithRangeStrategy.street = "693 W 1150 S"
        addressWithRangeStrategy.city = "provo"
        addressWithRangeStrategy.state = "utah"
        addressWithRangeStrategy.matchStrategy = kSSRange
        
        let addressWithInvalidStrategy = SSStreetLookup()
        addressWithInvalidStrategy.street = "9999 W 1150 S"
        addressWithInvalidStrategy.city = "provo"
        addressWithInvalidStrategy.state = "utah"
        addressWithInvalidStrategy.matchStrategy = kSSInvalid
        
        do {
            try batch.add(addressWithStrictStrategy)
            try batch.add(addressWithRangeStrategy)
            try batch.add(addressWithInvalidStrategy)
            try client?.send(batch)
        } catch let error as NSError {
            if error.domain == "SSSmartyErrorDomain" && error.code == SSErrors.BatchFullError.rawValue {
                print(String(format: "Description: %@", error.localizedDescription))
                return "Error. The batch is already full"
            }
            else {
                print(String(format: "Domain: %@", error.domain))
                print(String(format: "Error Code: %i", error.code))
                print(String(format: "Description: %@", error.localizedDescription))
                return "Error sending request"
            }
        }
        
        var lookups = batch.allLookups as [AnyObject] as! Array<SSStreetLookup>
        var output = String()
        
        for i in 0...batch.count() - 1 {
            let candidates = lookups[Int(i)].result as [AnyObject] as! Array<SSCandidate>
            
            if candidates.count == 0 {
                output += String(format: "\nAddress %i is invalid\n", i)
                continue
            }
            
            output += String(format: "\nAddress %i is valid. (There is at least one candidate", i) + "\n"
            
            for candidate in candidates {
                let components = candidate.components
                let metadata = candidate.metadata
                
                output += String(format: "\nCandidate %i ", candidate.candidateIndex)
                let match = batch.getLookupAt(i).matchStrategy
                output += String(format: "with %@ strategy", match!)
                output += "\nDelivery line 1:   " + candidate.deliveryLine1
                output += "\nLast line:         " + candidate.lastline
                
                if (components?.zipCode != nil) {
                    output += "\nZIP Code:          " + (components?.zipCode)!
                }
                if (components?.plus4Code != nil) {
                    output += "-" + (components?.plus4Code)!
                }
                if (metadata?.countyName != nil) {
                    output += "\nCounty:            " + (metadata?.countyName)!
                }
                
                output += "\nLatitude: " + String(format:"%f", (metadata?.latitude)!)
                output += "\nLongitude: " + String(format:"%f", (metadata?.longitude)!) + "\n"
            }
            output += "***********************************\n"
        }
        
        return output
    }
}
