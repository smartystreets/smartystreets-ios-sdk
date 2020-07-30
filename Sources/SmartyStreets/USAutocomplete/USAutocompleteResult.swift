import Foundation

@objcMembers public class USAutocompleteResult: NSObject, Codable {
    
    public var suggestions:[USAutocompleteSuggestion]?
    
    public init(dictionary: NSDictionary) {
        super.init()
        if let suggestions = dictionary["suggestions"] {
            self.suggestions = convertToSuggestionObjects(suggestions as! [[String:Any]])
        } else {
            self.suggestions = [USAutocompleteSuggestion]()
        }
    }
    
    func convertToSuggestionObjects(_ object:[[String:Any]]) -> [USAutocompleteSuggestion] {
        var mutable = [USAutocompleteSuggestion]()
        for city in object {
            mutable.append(USAutocompleteSuggestion(dictionary: city as NSDictionary))
        }
        return mutable
    }
    
    func getSuggestionAtIndex(index: Int) -> USAutocompleteSuggestion {
        if let suggestions = self.suggestions {
            return suggestions[index]
        } else {
            return USAutocompleteSuggestion(dictionary: NSDictionary())
        }
    }
}
