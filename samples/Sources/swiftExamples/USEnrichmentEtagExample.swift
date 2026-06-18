import Foundation
import SmartyStreets

class USEnrichmentEtagExample {
    var error: NSError! = nil

    func run() throws -> String {
        let authId = getEnvironmentVar("SMARTY_AUTH_ID") ?? ""
        let authToken = getEnvironmentVar("SMARTY_AUTH_TOKEN") ?? ""
        let client = ClientBuilder.withBasicAuth(authId: authId, authToken: authToken).buildUsEnrichmentApiClient()

        let smartyKey = "1962995076"
        var output = ""

        let first = EnrichmentLookup()
        first.setSmartyKey(smarty_key: smartyKey)
        let firstResults = client.sendBusinessLookup(inputLookup: first, error: &error)
        if let error = error {
            return "First call failed: \(error.localizedDescription)"
        }
        output += "First call: \((firstResults ?? []).count) result(s), Etag=\(first.getResponseEtag())\n"

        let second = EnrichmentLookup()
        second.setSmartyKey(smarty_key: smartyKey)
        second.setRequestEtag(etag: first.getResponseEtag())
        let secondResults = client.sendBusinessLookup(inputLookup: second, error: &error)
        if let error = error {
            return output + "Second call failed: \(error.localizedDescription)"
        }
        if (secondResults ?? []).isEmpty {
            output += "Second call: not modified, Etag=\(second.getResponseEtag())\n"
        } else {
            output += "Second call: modified, \((secondResults ?? []).count) result(s), Etag=\(second.getResponseEtag())\n"
        }

        return output
    }
}
