import Foundation
import SmartystreetsSDK

class USAutocompleteExample {
    func run() -> String {
        let client = SSClientBuilder(authId: MyCredentials.AuthId,
                                     authToken: MyCredentials.AuthToken).buildUsAutocompleteApiClient()
        
        let lookup = SSUSAutocompleteLookup(prefix: "4770 Lincoln Ave O")
        
        do {
            try client?.send(lookup)
        } catch let error as NSError {
            print(String(format: "Domain: %@", error.domain))
            print(String(format: "Error Code: %i", error.code))
            print(String(format: "Description: %@", error.localizedDescription))
            return "Error sending request"
        }
        
        var output = "*** Result with no filter ***\n"
        
        let result1 = lookup?.result as! Array<SSUSAutocompleteSuggestion>
        
        for suggestion in result1 {
            output += suggestion.text + "\n"
        }
        
        var error: NSError?
        lookup?.addStateFilter("IL")
        lookup?.setMaxSuggestions(5, error: &error)
        
        do {
            try client?.send(lookup)
        } catch let error as NSError {
            print(String(format: "Domain: %@", error.domain))
            print(String(format: "Error Code: %i", error.code))
            print(String(format: "Description: %@", error.localizedDescription))
            return "Error sending request"
        }
        
        let result2 = lookup?.result as! Array<SSUSAutocompleteSuggestion>
        
        output += "\n***Result with some filters ***\n"
        for suggestion in result2 {
            output += suggestion.text + "\n"
        }
        
        return output
    }
}
