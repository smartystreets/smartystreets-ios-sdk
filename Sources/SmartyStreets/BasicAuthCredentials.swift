import Foundation

class BasicAuthCredentials: SmartyCredentials {

    var authId: String
    var authToken: String

    init(authId: String, authToken: String) {
        if authId.isEmpty || authToken.isEmpty {
            fatalError("credentials (auth id, auth token) required")
        }
        self.authId = authId
        self.authToken = authToken
    }

    override func sign(request: SmartyRequest) {
        let credentials = "\(authId):\(authToken)"
        if let credentialsData = credentials.data(using: .utf8) {
            let base64Credentials = credentialsData.base64EncodedString()
            request.setValue(value: "Basic \(base64Credentials)", HTTPHeaderField: "Authorization")
        }
    }
}
