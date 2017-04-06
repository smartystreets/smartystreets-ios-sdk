import Foundation
import SmartystreetsSDK

class USStreetMultipleLookupsExample {
    func run() -> String {
        let client = SSClientBuilder(authId: MyCredentials.AuthId,
                                    authToken: MyCredentials.AuthToken).buildUsStreetApiClient()
        
        let batch = SSBatch()
        var error: NSError?
        
        let address0 = SSUSStreetLookup()
        address0.street = "1600 amphitheatre parkway"
        address0.city = "Mountain View"
        address0.state = "california"
        
        let address1 = SSUSStreetLookup(freeformAddress: "1 Rosedale, Baltimore, Maryland")
        address1?.setMaxCandidates(10, error: &error)
        
        let address2 = SSUSStreetLookup(freeformAddress: "123 Bogus Street, Pretend Lake, Oklahoma")
        
        let address3 = SSUSStreetLookup()
        address3.street = "1 Infinite Loop"
        address3.zipCode = "95014"

        do {
            try batch.add(address0)
            try batch.add(address1)
            try batch.add(address2)
            try batch.add(address3)
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
        
        var lookups = batch.allLookups as [AnyObject] as! Array<SSUSStreetLookup>
        var output = String()
        
        for i in 0...batch.count() - 1 {
            let candidates = lookups[Int(i)].result as [AnyObject] as! Array<SSUSStreetCandidate>
            
            if candidates.count == 0 {
                output += String(format: "\nAddress %i is invalid\n", i)
                continue
            }
            
            output += String(format: "\nAddress %i is valid. (There is at least one candidate", i) + "\n"
            
            for candidate in candidates {
                let components = candidate.components
                let metadata = candidate.metadata
                
                output += String(format: "\nCandidate %i :", candidate.candidateIndex)
                output += "\nDelivery line 1:   " + candidate.deliveryLine1
                output += "\nLast line:         " + candidate.lastline
                output += "\nZIP Code:          " + (components?.zipCode)! + "-" + (components?.plus4Code)!
                output += "\nCounty:            " + (metadata?.countyName)!
                output += "\nLatitude: " + String(format:"%f", (metadata?.latitude)!)
                output += "\nLongitude: " + String(format:"%f", (metadata?.longitude)!) + "\n"
            }
            output += "***********************************\n"
        }
        
        return output
    }
}
