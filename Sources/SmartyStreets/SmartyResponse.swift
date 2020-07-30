import Foundation

public class SmartyResponse {
    var statusCode:Int
    var payload:Data
    
    init(statusCode:Int, payload:Data) {
        self.statusCode = statusCode
        self.payload = payload
    }
}
