import UIKit

class ZipCodeSingleController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var result: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        city.delegate = self
        state.delegate = self
        zipcode.delegate = self
    }
    
    // MARK: Actions
    
    @IBAction func lookUp(_ sender: UIButton) {
        result.text = run()
    }
    
    
    func run() -> String {
        let client = SSClientBuilder(id: "KEY", hostname: "hostname").buildUsZIPCodeApiClient()
//        let authId = ProcessInfo.processInfo.environment["SMARTY_AUTH_ID"]
//        let authToken = ProcessInfo.processInfo.environment["SMARTY_AUTH_TOKEN"]
//        let client = SSClientBuilder(authId: authId ?? "", authToken: authToken ?? "").buildUsZIPCodeApiClient()
        
//        Documentation for input fields can be found at:
//        https://smartystreet.com/docs/us-zipcode-api#input-fields
        var lookup = USZipCodeLookup(city: self.city.text, state: self.state.text, zipcode: self.zipcode.text, inputId: String())
        
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
        
        let result = lookup.result as USZipCodeResult
        let zipCodes:[SSUSZipCode]? = result.zipCodes
        let cities:[SSUSCity]? = result.cities
        
        var output = "Results:"
        
        if let cities = cities, let zipCodes = zipCodes {
            for city in cities {
                output.append("""
                    \nCity: \(city.city ?? "")
                    State: \(city.state ?? "")
                    Mailable City: \(city.mailablecity ?? true)\n
                    """)
            }
            
            for zip in zipCodes {
                output.append("""
                    \nZIP Code: \(zip.zipCode ?? "")
                    Latitude: \(zip.latitude ?? 0)
                    Longitude: \(zip.longitude ?? 0)\n
                    """)
            }
            return output
        }
        return "Uncaught Error"
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
