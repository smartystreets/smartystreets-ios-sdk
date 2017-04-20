import Foundation
import SmartystreetsSDK

class InternationalStreetExample {
    func run() -> String {
        let client = SSClientBuilder(authId: MyCredentials.AuthId,
                                   authToken: MyCredentials.AuthToken).buildInternationalStreetApiClient()
        
        let lookup = SSInternationalStreetLookup(freeform: "Rua Padre Antonio D'Angelo 121 Casa Verde, Sao Paulo", withCountry: "Brazil")
        lookup?.enableGeocode(true)
        
        do {
            try client?.send(lookup)
        } catch let error as NSError {
            print(String(format: "Domain: %@", error.domain))
            print(String(format: "Error Code: %i", error.code))
            print(String(format: "Description: %@", error.localizedDescription))
            return "Error sending request"
        }
        
        let firstCandidate = lookup?.result[0] as! SSInternationalStreetCandidate
        var output = String()
        
        output += "Address is " + firstCandidate.analysis.verificationStatus
        output += "\nAddress precision: " + firstCandidate.analysis.addressPrecision + "\n"
        
        output += "\nFirst Line: " + firstCandidate.address1
        output += "\nSecond Line: " + firstCandidate.address2
        output += "\nThird Line: " + firstCandidate.address3
        output += "\nFourth Line: " + firstCandidate.address4
        
        let metadata = firstCandidate.metadata
        output += "\nLatitude: " + String(format: "%f", (metadata?.latitude)!)
        output += "\nLongitude: " + String(format: "%f", (metadata?.longitude)!)
        
        return output
    }
}
