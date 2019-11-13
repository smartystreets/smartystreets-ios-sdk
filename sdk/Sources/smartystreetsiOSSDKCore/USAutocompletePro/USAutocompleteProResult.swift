import Foundation

@objcMembers public class USAutocompleteProResult: NSObject, Codable {
    
    public var suggestions:[USAutocompleteProSuggestion]?
    
    public init(dictionary: NSDictionary) {
        super.init()
        if let suggestions = dictionary["suggestions"] {
            self.suggestions = convertToSuggestionObjects(suggestions as! [[String:Any]])
        } else {
            self.suggestions = [USAutocompleteProSuggestion]()
        }
    }
    
    func convertToSuggestionObjects(_ object:[[String:Any]]) -> [USAutocompleteProSuggestion] {
        var mutable = [USAutocompleteProSuggestion]()
        for city in object {
            mutable.append(USAutocompleteProSuggestion(dictionary: city as NSDictionary))
        }
        return mutable
    }
    
    func getSuggestionAtIndex(index: Int) -> USAutocompleteProSuggestion {
        if let suggestions = self.suggestions {
            return suggestions[index]
        } else {
            return USAutocompleteProSuggestion(dictionary: NSDictionary())
        }
    }
}
