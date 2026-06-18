import Foundation

@objcMembers public class USReverseGeoSource: NSObject {
    public static let all    = USReverseGeoSource(name: "all")
    public static let postal = USReverseGeoSource(name: "postal")

    public var name: String

    public init(name: String) {
        self.name = name
    }
}
