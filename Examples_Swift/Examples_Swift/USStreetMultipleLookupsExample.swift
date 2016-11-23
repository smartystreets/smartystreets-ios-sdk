import Foundation
import Smartystreets_iOS_SDK

class USStreetMultipleLookupsExample {
    func run() -> String {
        let client = SSStreetClientBuilder(authId: MyCredentials.AuthId,
                                            authToken: MyCredentials.AuthToken).build()
        
        let batch = SSStreetBatch()
        var error: NSError?
        
        let address0 = SSStreetLookup()
        address0.street = "1600 amphitheatre parkway"
        address0.city = "Mountain View"
        address0.state = "california"
        
        let address1 = SSStreetLookup(freeformAddress: "1 Rosedale, Baltimore, Maryland")
        address1?.setMaxCandidates(10, error: &error)
        
        let address2 = SSStreetLookup(freeformAddress: "123 Bogus Street, Pretend Lake, Oklahoma")
        
        let address3 = SSStreetLookup()
        address3.street = "1 Infinite Loop"
        address3.zipCode = "95014"
        
        batch.add(address0, error: &error)
        batch.add(address1, error: &error)
        batch.add(address2, error: &error)
        batch.add(address3, error: &error)
        
        if error != nil {
//            if error?.domain == "SSmartyErrorDomain" && error?.code == BatchFullError { //TODO: handle errors
//                print("Description: %@", error?.localizedDescription)
//                return "Error. The batch is already full"
//            }
        }

        client?.send(batch, error: &error)
        
        if error != nil {
            return "Error sending request" //TODO: handle errors
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
