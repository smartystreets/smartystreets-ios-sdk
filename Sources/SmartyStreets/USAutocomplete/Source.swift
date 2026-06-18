import Foundation

@objcMembers public class USAutocompleteSource: NSObject {
    public static let all    = USAutocompleteSource(name: "all")
    public static let postal = USAutocompleteSource(name: "postal")

    public var name: String

    public init(name: String) {
        self.name = name
    }
}
