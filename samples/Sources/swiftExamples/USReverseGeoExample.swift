import Foundation
import SmartyStreets

class USReverseGeoExample {
    func run() -> String {
        let id = "ID"
        let hostname = "HOSTNAME"
        //            The appropriate license values to be used for your subscriptions
        //            can be found on the Subscriptions page of the account dashboard.
        //            https://www.smartystreets.com/docs/cloud/licensing
        let client = ClientBuilder(id: id, hostname: hostname).withLicenses(licenses:["us-reverse-geocoding-cloud"]).buildUsReverseGeoApiClient()
        
        // Documentation for input fields can be found at:
        // https://smartystreets.com/docs/cloud/us-reverse-geo-api#http-input-fields
        
        var lookup = USReverseGeoLookup(latitude: 40.27644, longitude: -111.65747)
        
        var error: NSError! = nil
        
        _ = client.sendLookup(lookup: &lookup, error:&error)
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            NSLog(output)
            return output
        }
        
        let response:USReverseGeoResponse = lookup.response ?? USReverseGeoResponse(dictionary: NSDictionary())
        var output = "Results:\n"
        
        if response.results == nil {
            return "Error. Address is not valid"
        }
        
        let result = response.results![0]
        if let coordinate = result.coordinate, let address = result.address {
            output.append("""
                \nLatitude \(coordinate.latitude ?? 0.0)
                \nLongitude: \(coordinate.longitude ?? 0.0)\n
                \nDistance: \(result.distance ?? 0.0)
                \nStreet: \(address.street ?? "")
                \nCity: \(address.city ?? "")
                \nState Abbreviation: \(address.stateAbbreviation ?? "")
                \nZIP Code: \(address.zipcode ?? "")
                \nLicense: \(coordinate.getLicense())
                """)
        }
        return output
    }
}
