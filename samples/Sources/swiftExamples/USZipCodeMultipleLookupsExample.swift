import Foundation
import SmartyStreets

class USZipCodeMultipleLookupsExample {
    func run() -> String {
        let id = "ID"
        let hostname = "Hostname"
        let client = ClientBuilder(id: id, hostname: hostname).buildUsZIPCodeApiClient()
                
        let batch = USZipCodeBatch()
        var error:NSError! = nil
        
        //        Documentation for input fields can be found at:
        //        https://smartystreet.com/docs/us-zipcode-api#input-fields
        let lookup1 = USZipCodeLookup()
        lookup1.inputId = "011889998819991197253" // Optional ID from your system
        lookup1.zipcode = "12345" // A Lookup may have a ZIP Code, city and state, or city, state, and ZIP Code
        
        let lookup2 = USZipCodeLookup()
        lookup2.city = "Phoenix"
        lookup2.state = "Arizona"
        
        let lookup3 = USZipCodeLookup(city: "cupertino", state:"CA", zipcode: "95014", inputId: nil)
        
        _ = batch.add(newAddress: lookup1, error: &error)
        _ = batch.add(newAddress: lookup2, error: &error)
        _ = batch.add(newAddress: lookup3, error: &error)
        
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Code: \(error.code)
            Description: \(error.userInfo[NSLocalizedDescriptionKey] ?? "")
            """
            return output
        }
        
        _ = client.sendBatch(batch: batch, error: &error)
        
        var output = "Results:\n"
        
        if let error = error {
            output = """
            Domain: \(error.domain)
            Code: \(error.code)
            Description: \(error.userInfo[NSLocalizedDescriptionKey] ?? "")
            """
            NSLog(output)
            return output
        }
        
        let lookups = batch.allLookups as! [USZipCodeLookup]
        
        for lookup in lookups {
            output.append("\nInput ID: \(lookup.inputId ?? "")")
            if let cities = lookup.result.cities, let zipCodes = lookup.result.zipCodes {
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
        }
        return output
    }
}
