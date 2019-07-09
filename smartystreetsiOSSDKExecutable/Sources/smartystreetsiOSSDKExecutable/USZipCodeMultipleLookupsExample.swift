import Foundation
import smartystreetsiOSSDKCore

class USZipCodeMultipleLookupsExample {
    func run() -> String {
        //        let authId = ProcessInfo.processInfo.environment["SMARTY_AUTH_ID"]
        //        let authToken = ProcessInfo.processInfo.environment["SMARTY_AUTH_TOKEN"]
        //        let client = ClientBuilder(authId: authId ?? "", authToken: authToken ?? "").buildUsZIPCodeApiClient()
        let authId = "ID"
        let authToken = "TOKEN"
        let client = ClientBuilder(authId: authId, authToken: authToken).buildUsZIPCodeApiClient()
        
        let batch = USZipCodeBatch()
        var error:NSError! = nil
        
        //        Documentation for input fields can be found at:
        //        https://smartystreet.com/docs/us-zipcode-api#input-fields
        let lookup1 = USZipCodeLookup()
        lookup1.zipcode = "12345"
        
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
