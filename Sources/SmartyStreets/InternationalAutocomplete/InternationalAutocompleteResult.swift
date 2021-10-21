import Foundation

@objcMembers public class InternationalAutocompleteResult: NSObject, Codable {
    
    public var candidates:[InternationalAutocompleteCandidate]?
    
    public init(dictionary: NSDictionary) {
        super.init()
        if let candidates = dictionary["candidates"] {
            self.candidates = convertToCandidateObjects(candidates as! [[String:Any]])
        } else {
            self.candidates = [InternationalAutocompleteCandidate]()
        }
    }
    
    func convertToCandidateObjects(_ object:[[String:Any]]) -> [InternationalAutocompleteCandidate] {
        var mutable = [InternationalAutocompleteCandidate]()
        for suggestion in object {
            mutable.append(InternationalAutocompleteCandidate(dictionary: suggestion as NSDictionary))
        }
        return mutable
    }
    
    func getCandidateAtIndex(index: Int) -> InternationalAutocompleteCandidate {
        if let candidates = self.candidates {
            return candidates[index]
        } else {
            return InternationalAutocompleteCandidate(dictionary: NSDictionary())
        }
    }
}
