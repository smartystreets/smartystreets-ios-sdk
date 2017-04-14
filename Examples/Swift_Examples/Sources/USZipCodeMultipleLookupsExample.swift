import Foundation
import SmartystreetsSDK

class USZipCodeMultipleLookupsExample {
    
    func run() -> String {
        let client = SSClientBuilder(authId: MyCredentials.AuthId,
                                     authToken: MyCredentials.AuthToken).buildUsZIPCodeApiClient();
        
        let batch = SSBatch()
        
        let lookup1 = SSUSZipCodeLookup()
        lookup1.zipcode = "12345" // A Lookup may have a ZIP Code, city and state, or city, state, and ZIP Code
        
        let lookup2 = SSUSZipCodeLookup()
        lookup2.city = "Phoenix"
        lookup2.state = "Arizona"
        
        let lookup3 = SSUSZipCodeLookup(city: "cupertino", state: "CA", zipcode: "95014")
        
        do {
            try batch.add(lookup1)
            try batch.add(lookup2)
            try batch.add(lookup3)
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
        
        var lookups = batch.allLookups as [AnyObject] as! Array<SSUSZipCodeLookup>
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
                output += "\nCity: " + (city as!SSUSCity).city
                output += "\nState: " + (city as!SSUSCity).state
                output += "\nMailable City: " + ((city as!SSUSCity).mailableCity ? "YES" : "NO") + "\n"
            }
            
            output += "\n"
            let zipCodes = result?.zipCodes
            output += String(format:"%i", (zipCodes?.count)!)
            output += " ZIP Code match(es):"
            
            for zip in zipCodes! {
                output += "\nZIP Code: " + (zip as! SSUSZipCode).zipCode
                output += "\nCounty: " + (zip as! SSUSZipCode).countyName
                output += "\nLatitude: " + String(format:"%f", (zip as! SSUSZipCode).latitude)
                output += "\nLongitude: " + String(format:"%f", (zip as! SSUSZipCode).longitude) + "\n"
            }
            output += "***********************************\n"
        }
        
        return output
    }
}
