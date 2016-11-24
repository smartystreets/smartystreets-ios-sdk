import Foundation
import Smartystreets_iOS_SDK

class ZipCodeSingleLookupExample {

    func run() -> String {
//        let mobile = SSSharedCredentials(id: "key", hostname: "host") //TODO test with mobile credentials
//        let client = SSZipCodeClientBuilder(signer: mobile).build()
        let client = SSZipCodeClientBuilder(authId: MyCredentials.AuthId,
                                            authToken: MyCredentials.AuthToken).build()
        
        let lookup = SSZipCodeLookup()
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
        
        let result: SSResult = lookup.result
        let zipCodes = result.zipCodes
        let cities = result.cities
        
        var output: String = String()
        
        if (cities == nil && zipCodes == nil) {
            output += "Error getting cities and zip codes."
            return output
        }
        
        for city in cities! {
            output += "\nCity: " + (city as! SSCity).city
            output += "\nState: " + (city as! SSCity).state
            output += "\nMailable City: " + ((city as! SSCity).mailableCity ? "YES" : "NO") + "\n"
        }
        
        for zip in zipCodes! {
            output += "\nZIP Code: " + (zip as! SSZipCode).zipCode
            output += "\nLatitude: " + String(format:"%f", (zip as! SSZipCode).latitude)
            output += "\nLongitude: " + String(format:"%f", (zip as! SSZipCode).longitude) + "\n"
        }
        
        return output
    }
}
