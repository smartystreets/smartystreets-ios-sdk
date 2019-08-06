import UIKit

class USStreetSingleLookup: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var Output: UITextView!
    @IBOutlet weak var freeform: UITextField!
    
    @IBAction func Lookup(_ sender: Any) {
        Output.text = run()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        street.delegate = self
        city.delegate = self
        state.delegate = self
        freeform.delegate = self
    }
    
    func run() -> String {
        let client = SSClientBuilder(id: "key", hostname: "hostname").buildUsStreetApiClient()
//        let authId = ProcessInfo.processInfo.environment["SMARTY_AUTH_ID"]
//        let authToken = ProcessInfo.processInfo.environment["SMARTY_AUTH_TOKEN"]
//        let client = SSClientBuilder(authId: authId ?? "", authToken: authToken ?? "").buildUsStreetApiClient()
        
//        Documentation for input fields can be found at:
//        https://smartystreets.com/docs/us-street-api#input-fields
        var lookup = USStreetLookup()
        if let freeform = freeform.text {
            lookup = USStreetLookup(freeformAddress: freeform)
        } else {
            lookup.street = self.street.text
            lookup.city = self.city.text
            lookup.state = self.state.text
        }
        lookup.matchStrategy = "invalid"
        
        var error:NSError! = nil
        _ = client.sendLookup(lookup: &lookup, error: &error)
        
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            NSLog(output)
            return output
        }
        
        let results:[USStreetCandidate] = lookup.result
        var output = "Results:\n"
        
        if results.count == 0 {
            return "Error. Address is not valid"
        }
        
        let candidate = results[0]
        
        output.append("""
            Address is valid. (There is at least one candidate)\n\n
            \nZIP Code: \(candidate.components?.zipCode ?? "")
            \nCounty: \(candidate.metadata?.countyName ?? "")
            \nLatitude: \(candidate.metadata?.latitude ?? 0.0)
            \nLongitude: \(candidate.metadata?.longitude ?? 0.0)
            """)
        return output
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
