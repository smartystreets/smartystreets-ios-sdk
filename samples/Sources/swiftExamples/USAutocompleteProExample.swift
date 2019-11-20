import Foundation
import sdk

class USAutocompleteProExample {
    func run() -> String {
        let id = "23161985642637220"
        let hostname = "api.integration.smartystreets.com"
        let client = ClientBuilder(id: id, hostname: hostname).buildUSAutocompleteProApiClient()

        //            Documentation for input fields can be found at:
        //            https://smartystreets.com/docs/cloud/us-autocomplete-api#pro-http-request-input-fields

        var lookup = USAutocompleteProLookup().withSearch(search: "1 King St Apt")
        ////////////////////// Can be sent with or without the following fields //////////////////////
        lookup.addCityFilter(city: "Dorchester")
        lookup.addCityFilter(city: "Boston")
        lookup.addStateFilter(state: "MA")
        lookup.addPreferCity(city: "Dorchester")
        lookup.addPreferState(state: "MA")
        lookup.maxResults = 5
        lookup.preferGeolocation = GeolocateType(name: "none")
        lookup.preferRatio = 3
        ///////////////////////////////////////////////////////////////////////////////////////////////
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
