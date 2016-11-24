import Foundation
import Smartystreets_iOS_SDK

class USStreetSingleAddressExample {
    
    func run() -> String {
        //        let mobile = SSSharedCredentials(id: "key", hostname: "host")
        //        let client = SSZipCodeClientBuilder(signer: mobile).build()
        let client = SSStreetClientBuilder(authId: MyCredentials.AuthId,
                                            authToken: MyCredentials.AuthToken).build()
        
        let lookup = SSStreetLookup()
        lookup.street = "1600 Amphitheatre Pkwy"
        lookup.city = "Mountain View"
        lookup.state = "CA"
        
        do {
            try client?.send(lookup)
        } catch let error as NSError {
            print(String(format: "Domain: %@", error.domain))
            print(String(format: "Error Code: %i", error.code))
            print(String(format: "Description: %@", error.localizedDescription))
            return "Error sending request"
        }
        
        let results = lookup.result
        var output = String()
        
        if results?.count == 0 {
            output += "Error. Address is not valid"
            return output
        }
        
        let candidate: SSCandidate = results?[0] as! SSCandidate
        
        output += "Address is valid. (There is at least one candidate)\n\n"
        output += "\nZIP Code: " + candidate.components.zipCode
        output += "\nCounty: " + candidate.metadata.countyName
        output += "\nLatitude: " + String(format:"%f", candidate.metadata.latitude)
        output += "\nLongitude: " + String(format:"%f", candidate.metadata.longitude)
        
        return output;
    }
}
