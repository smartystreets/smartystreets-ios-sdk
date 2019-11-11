//import Foundation
//import sdk
//
//class USAutocompleteProExample {
//    func run() -> String {
//        let id = "ID"
//        let hostname = "Hostname"
//        let client = ClientBuilder(id: id, hostname: hostname).buildUSAutocompleteProApiClient()
//
//        //            Documentation for input fields can be found at:
//        //            https://smartystreets.com/docs/us-autocomplete-api#http-request-input-fields
//
//        var lookup = USAutocompleteProLookup().withSearch(search: "4770 Lincoln Ave O")
//        ////////////////////// Can be sent with or without the following fields //////////////////////
//        lookup.addCityFilter(city: "Ogden")
//        lookup.addStateFilter(state: "IL")
//        lookup.addPreferCity(city: "Fallon")
//        lookup.addPreferState(state: "IL")
//        lookup.maxSuggestions = 5
//        lookup.preferGeolocation = GeolocateType(name: "null")
//        lookup.preferRatio = 0.333333
//        ///////////////////////////////////////////////////////////////////////////////////////////////
//        var error:NSError! = nil
//
//        _ = client.sendLookup(lookup: &lookup, error: &error)
//
//        if let error = error {
//            let output = """
//            Domain: \(error.domain)
//            Error Code: \(error.code)
//            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
//            """
//            return output
//        }
//
//        var output = "Result:\n"
//
//        if let result = lookup.result, let suggestions = result.suggestions {
//            for suggestion in suggestions {
//                 output.append("\(suggestion.text ?? "")\n")
//            }
//        }
//        return output
//    }
//}
