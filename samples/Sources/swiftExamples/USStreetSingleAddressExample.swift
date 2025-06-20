import Foundation
import SmartyStreets

class USStreetSingleAddressExample {
    func run() -> String {
        //            The appropriate license values to be used for your subscriptions
        //            can be found on the Subscriptions page of the account dashboard.
        //            https://www.smartystreets.com/docs/cloud/licensing
        //            We recommend storing your authentication credentials in environment variables.
        //            for server-to-server requests, use this code:
        //let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        //let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        //let client = ClientBuilder(authId:authId, authToken:authToken).buildUsStreetApiClient()
        
        // for client-side requests (browser/mobile), use this code:
        let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        let client = ClientBuilder(id: id, hostname: hostname).buildUsStreetApiClient()
                
        //        Documentation for input fields can be found at:
        //        https://smartystreets.com/docs/us-street-api#input-fields
        var lookup = USStreetLookup()
        lookup.inputId = "24601"
        lookup.addressee = "John Doe"
        lookup.street = "1600 Amphitheatre Pkwy"
        lookup.street2 = "closet under the stairs"
        lookup.secondary = "APT 2"
        lookup.urbanization = "" // Only applies to Puerto Rico addresses
        lookup.city = "Mountain View"
        lookup.state = "CA"
        lookup.zipCode = "94043"
        lookup.maxCandidates = 3
        lookup.matchStrategy = "invalid" // "invalid" is the most permissive match,
                                         // this will always return at least one result even if the address is invalid.
                                         // Refer to the documentation for additional Match Strategy options.
        
        // Uncomment the below line to add a custom parameter to a lookup:
        //lookup.addCustomParameter(parameter: "parameter", value: "value")
        
        var error: NSError! = nil
        _ = client.sendLookup(lookup: &lookup, error: &error)
        
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description: \(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            return output
        }
        
        let results:[USStreetCandidate] = lookup.result
        var output = "Results:\n"
        
        if results.count == 0 {
            return "Error. Address is not valid"
        }
        
        let candidate = results[0]
        
        output.append("""
            There is at least one candidate.\n If the match parameter is set to STRICT, the address is valid.\n Otherwise, check the Analysis output fields to see if the address is valid.\n
            \nZIP Code: \(candidate.components?.zipCode ?? "")
            \nCounty: \(candidate.metadata?.countyName ?? "")
            \nLatitude: \(candidate.metadata?.latitude ?? 0.0)
            \nLongitude: \(candidate.metadata?.longitude ?? 0.0)
            """
        )
        return output
    }
}

