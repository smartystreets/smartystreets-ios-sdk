import Foundation
import SmartystreetsSDK

class USStreetSingleAddressExample {
    
    func run() -> String {
        let mobile = SSSharedCredentials(id: MyCredentials.SmartyWebsiteKey, hostname: MyCredentials.Host)
        let client = SSClientBuilder(signer: mobile).buildUsStreetApiClient()
//        let client = SSClientBuilder(authId: MyCredentials.AuthId,
//                                            authToken: MyCredentials.AuthToken).buildUsStreetApiClient()
        
        let lookup = SSUSStreetLookup()
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
        
        let candidate: SSUSStreetCandidate = results?[0] as! SSUSStreetCandidate
        
        output += "Address is valid. (There is at least one candidate)\n\n"
        output += "\nZIP Code: " + candidate.components.zipCode
        output += "\nCounty: " + candidate.metadata.countyName
        output += "\nLatitude: " + String(format:"%f", candidate.metadata.latitude)
        output += "\nLongitude: " + String(format:"%f", candidate.metadata.longitude)
        
        return output;
    }
}
