import Foundation
import Smartystreets_iOS_SDK

class SSZipCodeSingleLookupExample {

    func run() -> String {
//        let mobile = SSSharedCredentials(id: "key", hostname: "host")
//        let client = SSZipCodeClientBuilder(signer: mobile).build()
        let client = SSZipCodeClientBuilder(authId: "AUTH_ID", //TODO: figure out why can't send request in Swift
                                            authToken: "AUTH_TOKEN").build()
        
        let lookup = SSZipCodeLookup()
        lookup.city = "Mountain View"
        lookup.state = "California"
        
        var error: NSError?
        client!.send(lookup, error: &error)
        
        if (error != nil) {
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
            output += "\nMailable City: " + ((city as! SSCity).mailableCity ? "YES" : "NO")
            output += "\n"
        }
        
        for zip in zipCodes! {
            output += "\nZIP Code: " + (zip as! SSZipCode).zipCode
            output += "\nLatitude: " + String(format:"%@", (zip as! SSZipCode).latitude)
            output += "\nLongitude: " + String(format:"%@", (zip as! SSZipCode).longitude)
            output += "\n"
        }
        
        return output
    }

}