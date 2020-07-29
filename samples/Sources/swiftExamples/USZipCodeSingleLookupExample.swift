import Foundation
import SmartyStreets

class USZipCodeSingleLookupExample {
    func run() -> String {
        let id = "ID"
        let hostname = "Hostname"
        let client = ClientBuilder(id: id, hostname: hostname).buildUsZIPCodeApiClient()
        
        //        Documentation for input fields can be found at:
        //        https://smartystreet.com/docs/us-zipcode-api#input-fields
        var lookup = USZipCodeLookup()
        lookup.inputId = "dfc33cb6-829e-4fea-aa1b-b6d6580f0817" // Optional ID from your system
        lookup.city = "Mountain View"
        lookup.state = "California"
        lookup.zipcode = "94043"
        
        var error:NSError! = nil
        _ = client.sendLookup(lookup: &lookup, error: &error)
        
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            NSLog(output)
            return output
        }
        
        let result = lookup.result as USZipCodeResult
        let zipCodes:[USZipCode]? = result.zipCodes
        let cities:[USCity]? = result.cities
        
        var output = "Results:"
        
        if let cities = cities, let zipCodes = zipCodes {
            for city in cities {
                output.append("""
                    \nCity: \(city.city ?? "")
                    State: \(city.state ?? "")
                    Mailable City: \(city.mailablecity ?? true)\n
                    """)
            }
            
            for zip in zipCodes {
                output.append("""
                    \nZIP Code: \(zip.zipCode ?? "")
                    Latitude: \(zip.latitude ?? 0)
                    Longitude: \(zip.longitude ?? 0)\n
                    """)
            }
        }
        return output
    }
}
