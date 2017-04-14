import Foundation
import SmartystreetsSDK

class USZipCodeSingleLookupExample {

    func run() -> String {
        let mobile = SSSharedCredentials(id: MyCredentials.SmartyWebsiteKey, hostname: MyCredentials.Host)
        let client = SSClientBuilder(signer: mobile).buildUsZIPCodeApiClient()
//        let client = SSClientBuilder(authId: MyCredentials.AuthId,
//                                            authToken: MyCredentials.AuthToken).buildUsZIPCodeApiClient()
        
        let lookup = SSUSZipCodeLookup()
        lookup.city = "Mountain View"
        lookup.state = "California"
        
        do {
            try client?.send(lookup)
        } catch let error as NSError {
            print(String(format: "Domain: %@", error.domain))
            print(String(format: "Error Code: %i", error.code))
            print(String(format: "Description: %@", error.localizedDescription))
            return "Error sending request"
        }
        
        let result: SSUSZipCodeResult = lookup.result
        let zipCodes = result.zipCodes
        let cities = result.cities
        
        var output: String = String()
        
        if (cities == nil && zipCodes == nil) {
            output += "Error getting cities and zip codes."
            return output
        }
        
        for city in cities! {
            output += "\nCity: " + (city as!SSUSCity).city
            output += "\nState: " + (city as!SSUSCity).state
            output += "\nMailable City: " + ((city as!SSUSCity).mailableCity ? "YES" : "NO") + "\n"
        }
        
        for zip in zipCodes! {
            output += "\nZIP Code: " + (zip as! SSUSZipCode).zipCode
            output += "\nLatitude: " + String(format:"%f", (zip as! SSUSZipCode).latitude)
            output += "\nLongitude: " + String(format:"%f", (zip as! SSUSZipCode).longitude) + "\n"
        }
        
        return output
    }
}
