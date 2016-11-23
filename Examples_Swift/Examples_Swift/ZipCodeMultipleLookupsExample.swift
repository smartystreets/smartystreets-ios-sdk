import Foundation
import Smartystreets_iOS_SDK

class ZipCodeMultipleLookupsExample {
    
    func run() -> String {
        let client = SSZipCodeClientBuilder(authId: MyCredentials.AuthId,
                                            authToken: MyCredentials.AuthToken).build()
        
        let batch = SSZipCodeBatch()
        
        let lookup1 = SSZipCodeLookup()
        lookup1.zipcode = "12345" // A Lookup may have a ZIP Code, city and state, or city, state, and ZIP Code
        
        let lookup2 = SSZipCodeLookup()
        lookup2.city = "Phoenix"
        lookup2.state = "Arizona"
        
        let lookup3 = SSZipCodeLookup(city: "cupertino", state: "CA", zipcode: "95014")
        
        var error: NSError?
        batch.add(lookup1, error: &error)
        batch.add(lookup2, error: &error)
        batch.add(lookup3, error: &error)
        
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
        
        var lookups = batch.allLookups as [AnyObject] as! Array<SSZipCodeLookup>
        var output = String()
        
        for i in 0...batch.count() - 1 {
            let result = lookups[Int(i)].result
            output += "\nLookup " + String(format:"%i", i) + "\n"
            
            if result?.status != nil {
                output += "Status: " + (result?.status)!
                output += "\nReason: " + (result?.reason)! + "\n"
                continue
            }
            
            if result?.cities == nil && result?.zipCodes == nil {
                output += "Error getting cities and zip codes.\n\n"
                output += "***************\n\n"
                continue
            }
            
            let cities = result?.cities
            output += String(format:"%i", (cities?.count)!)
            output += " City and States match(es)"
            
            for city in cities! {
                output += "\nCity: " + (city as! SSCity).city
                output += "\nState: " + (city as! SSCity).state
                output += "\nMailable City: " + ((city as! SSCity).mailableCity ? "YES" : "NO") + "\n"
            }
            
            output += "\n"
            let zipCodes = result?.zipCodes
            output += String(format:"%i", (zipCodes?.count)!)
            output += " ZIP Code match(es):"
            
            for zip in zipCodes! {
                output += "\nZIP Code: " + (zip as! SSZipCode).zipCode
                output += "\nCounty: " + (zip as! SSZipCode).countyName
                output += "\nLatitude: " + String(format:"%f", (zip as! SSZipCode).latitude)
                output += "\nLongitude: " + String(format:"%f", (zip as! SSZipCode).longitude) + "\n"
            }
            output += "***********************************\n"
        }
        
        return output
    }
}
