import XCTest
@testable import SmartyStreets

class BasicAuthCredentialsTests: XCTestCase {

    var authId = "testID"
    var authToken = "testToken"
    var basicAuthCredentials: BasicAuthCredentials!
    var request: SmartyRequest!

    override func setUp() {
        super.setUp()
        self.request = SmartyRequest()
        self.basicAuthCredentials = BasicAuthCredentials(authId: self.authId, authToken: self.authToken)
    }

    override func tearDown() {
        super.tearDown()
        self.basicAuthCredentials = nil
    }

    func testBasicAuthCredentialsPopulated() {
        XCTAssertEqual(self.basicAuthCredentials.authId, self.authId)
        XCTAssertEqual(self.basicAuthCredentials.authToken, self.authToken)
    }

    func testBasicAuthCredentialsWithSpecialCharacters() {
        let cred = BasicAuthCredentials(authId: "test@id#123", authToken: "token!@#$%^&*()")

        XCTAssertEqual(cred.authId, "test@id#123")
        XCTAssertEqual(cred.authToken, "token!@#$%^&*()")
    }

    func testSignSetsAuthorizationHeader() {
        self.basicAuthCredentials.sign(request: request)

        let authHeader = self.request.headers["Authorization"]
        XCTAssertNotNil(authHeader)
        XCTAssertTrue(authHeader!.hasPrefix("Basic "))

        // Verify the base64 encoded credentials
        let expectedCredentials = "\(authId):\(authToken)"
        let expectedBase64 = Data(expectedCredentials.utf8).base64EncodedString()
        XCTAssertEqual(authHeader, "Basic \(expectedBase64)")
    }

    func testSignWithPasswordContainingColon() {
        let cred = BasicAuthCredentials(authId: "validUserID", authToken: "password:with:colons")
        cred.sign(request: self.request)

        let authHeader = self.request.headers["Authorization"]
        XCTAssertNotNil(authHeader)

        let expectedCredentials = "validUserID:password:with:colons"
        let expectedBase64 = Data(expectedCredentials.utf8).base64EncodedString()
        XCTAssertEqual(authHeader, "Basic \(expectedBase64)")
    }

    func testSignWithSpecialCharacters() {
        let cred = BasicAuthCredentials(authId: "user@domain.com", authToken: "p@ssw0rd!")
        cred.sign(request: self.request)

        let authHeader = self.request.headers["Authorization"]
        XCTAssertNotNil(authHeader)

        let expectedCredentials = "user@domain.com:p@ssw0rd!"
        let expectedBase64 = Data(expectedCredentials.utf8).base64EncodedString()
        XCTAssertEqual(authHeader, "Basic \(expectedBase64)")
    }

    func testSignWithUnicodeCharacters() {
        let cred = BasicAuthCredentials(authId: "用户", authToken: "密码")
        cred.sign(request: self.request)

        let authHeader = self.request.headers["Authorization"]
        XCTAssertNotNil(authHeader)

        let expectedCredentials = "用户:密码"
        let expectedBase64 = Data(expectedCredentials.utf8).base64EncodedString()
        XCTAssertEqual(authHeader, "Basic \(expectedBase64)")
    }

    func testSignOverwritesExistingHeader() {
        self.request.setValue(value: "Bearer oldtoken", HTTPHeaderField: "Authorization")

        self.basicAuthCredentials.sign(request: self.request)

        let authHeader = self.request.headers["Authorization"]
        XCTAssertNotNil(authHeader)
        XCTAssertTrue(authHeader!.hasPrefix("Basic "))
        XCTAssertFalse(authHeader!.contains("Bearer"))
    }

    func testDoesNotAddQueryParameters() {
        self.basicAuthCredentials.sign(request: request)

        // Basic auth should NOT add auth-id or auth-token to query params
        XCTAssertNil(self.request.parameters["auth-id"])
        XCTAssertNil(self.request.parameters["auth-token"])
    }
}
