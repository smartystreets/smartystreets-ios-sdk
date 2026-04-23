import Foundation

public class SmartyResponse {
    var statusCode:Int
    var payload:Data
    var headers:[String:String]

    init(statusCode:Int, payload:Data) {
        self.statusCode = statusCode
        self.payload = payload
        self.headers = [:]
    }

    init(statusCode:Int, payload:Data, headers:[String:String]) {
        self.statusCode = statusCode
        self.payload = payload
        self.headers = headers
    }
}
