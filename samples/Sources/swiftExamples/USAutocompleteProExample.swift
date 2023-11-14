import Foundation
import SmartyStreets

class USAutocompleteProExample {
    func run() -> String {
        //            The appropriate license values to be used for your subscriptions
        //            can be found on the Subscriptions page of the account dashboard.
        //            https://www.smartystreets.com/docs/cloud/licensing
        //            We recommend storing your authentication credentials in environment variables.
        //            for server-to-server requests, use this code:
        //let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        //let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        //let client = ClientBuilder(authId:authId, authToken:authToken).withLicenses(licenses:["us-autocomplete-pro-cloud"]).buildUSAutocompleteProApiClient()
        
        // for client-side requests (browser/mobile), use this code:
        let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        let client = ClientBuilder(id: id, hostname: hostname).withLicenses(licenses:["us-autocomplete-pro-cloud"]).buildUSAutocompleteProApiClient()
        
        //            Documentation for input fields can be found at:
        //            https://smartystreets.com/docs/cloud/us-autocomplete-api#pro-http-request-input-fields

        var lookup = USAutocompleteProLookup().withSearch(search: "1042 W Center")
        
        var error:NSError! = nil
        
        _ = client.sendLookup(lookup: &lookup, error: &error)
        
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            return output
        }
        
        var output = "Result:\n"
        
        if let result = lookup.result, let suggestions = result.suggestions {
            for suggestion in suggestions {
                output.append("\(buildAddress(suggestion: suggestion))\n")
            }
        }
        
        output.append("\nResult with filters:\n")
        
        ////////////////////// Can be sent with or without the following fields //////////////////////
        lookup.addCityFilter(city: "Denver,Aurora,CO")
        lookup.addCityFilter(city: "Orem,UT")
        lookup.addPreferCity(city: "Orem")
        lookup.addPreferState(state: "UT")
        lookup.maxResults = 5
        lookup.preferGeolocation = GeolocateType(name: "none")
        lookup.preferRatio = 33
        lookup.selected = "1042 W Center St Apt A (24) Orem UT 84057"
        lookup.source = "all"
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        _ = client.sendLookup(lookup: &lookup, error: &error)

        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            return output
        }

        if let result = lookup.result, let suggestions = result.suggestions {
            for suggestion in suggestions {
                output.append("\(buildAddress(suggestion: suggestion))\n")
            }
        }
        return output
    }
    
    func buildAddress(suggestion: USAutocompleteProSuggestion) -> String {
        var whiteSpace = ""
        if let entries = suggestion.entries {
            if entries > 1 {
                whiteSpace.append(" (\(entries) entries)")
            }
        }
        return "\(suggestion.streetLine ?? "") \(suggestion.secondary ?? "") \(whiteSpace) \(suggestion.city ?? ""), \(suggestion.state ?? "") \(suggestion.zipcode ?? "")"
    }
}
