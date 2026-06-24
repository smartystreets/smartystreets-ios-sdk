import Foundation
import SmartyStreets

// This example is for US Autocomplete (V2). It has the same name as a previous product
// which has been deprecated since 2022, which we refer to as US Autocomplete Basic.
// If you are still using US Autocomplete Basic, this SDK will not work.
class USAutocompleteExample {
    func run() -> String {
        //            The appropriate license values to be used for your subscriptions
        //            can be found on the Subscriptions page of the account dashboard.
        //            https://www.smartystreets.com/docs/cloud/licensing
        //            We recommend storing your authentication credentials in environment variables.
        //            for client-side requests (browser/mobile), use this code:
        //let id = getEnvironmentVar("SMARTY_AUTH_WEB") ?? ""
        //let hostname = getEnvironmentVar("SMARTY_AUTH_REFERER") ?? ""
        //let client = ClientBuilder(id: id, hostname: hostname).buildUSAutocompleteApiClient()

        // for server-to-server requests, use this code:
        let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken).buildUSAutocompleteApiClient()

        //            Documentation for input fields can be found at:
        //            https://www.smarty.com/docs/apis/us-autocomplete-v2/reference#http-request-input-fields

        var lookup = USAutocompleteLookup().withSearch(search: "1042 W Center")

        // Uncomment the below line to add a custom parameter to a lookup:
        //lookup.addCustomParameter(parameter: "parameter", value: "value")

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
        lookup.source = .all
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

        var entryId:String? = nil
        if let result = lookup.result, let suggestions = result.suggestions {
            for suggestion in suggestions {
                output.append("\(buildAddress(suggestion: suggestion))\n")
                if let id = suggestion.entryId, !id.isEmpty {
                    entryId = id
                }
            }
        }

        // Expand the secondaries of a result that has an entry_id by passing it back as the selected address.
        if let entryId = entryId {
            lookup.selected = entryId

            _ = client.sendLookup(lookup: &lookup, error: &error)

            if let error = error {
                let output = """
                Domain: \(error.domain)
                Error Code: \(error.code)
                Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
                """
                return output
            }

            output.append("\nSecondaries:\n")
            if let result = lookup.result, let suggestions = result.suggestions {
                for suggestion in suggestions {
                    output.append("\(buildAddress(suggestion: suggestion))\n")
                }
            }
        }

        return output
    }

    func buildAddress(suggestion: USAutocompleteSuggestion) -> String {
        var whiteSpace = ""
        if let entries = suggestion.entries {
            if entries > 1 {
                whiteSpace.append(" (\(entries) entries)")
            }
        }
        return "\(suggestion.streetLine ?? "") \(suggestion.secondary ?? "") \(whiteSpace) \(suggestion.city ?? ""), \(suggestion.state ?? "") \(suggestion.zipcode ?? "")"
    }
}
