import Foundation

@objcMembers public class USAutocompleteProSource: NSObject {
    public static let all    = USAutocompleteProSource(name: "all")
    public static let postal = USAutocompleteProSource(name: "postal")

    public var name: String

    public init(name: String) {
        self.name = name
    }
}
