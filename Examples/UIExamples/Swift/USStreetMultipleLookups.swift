import UIKit

class USStreetMultipleLookups: UIViewController, UITextFieldDelegate {
    
    var batch = USStreetBatch()
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var freeform: UITextField!
    @IBOutlet weak var results: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        street.delegate = self
        city.delegate = self
        state.delegate = self
        freeform.delegate = self
    }
    
    @IBAction func add(_ sender: Any) {
//        Documentation for input fields can be found at:
//        https://smartystreets.com/docs/us-street-api#input-fields
        
        var address = USStreetLookup()
        if freeform.text != "" {
            if let freeform = freeform.text {
                address = USStreetLookup(freeformAddress: freeform)
            }
        } else {
            address.street = street.text
            address.city = city.text
            address.state = state.text
        }
        var error:NSError! = nil
        
        _ = batch.add(newAddress: address, error: &error)
        
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            NSLog(output)
            results.text = output
        }
    }
    
    @IBAction func lookup(_ sender: Any) {
        results.text = run()
        self.batch = USStreetBatch()
    }
    
    func run() -> String{
        //        let mobile = SSSharedCredentials(id: "KEY", hostname: "HOST")
        //        let client = SSClientBuilder(withSigner: mobile).buildUsZIPCodeApiClient()
        if let authId = ProcessInfo.processInfo.environment["SMARTY_AUTH_ID"], let authToken = ProcessInfo.processInfo.environment["SMARTY_AUTH_TOKEN"] {
            let client = SSClientBuilder(authId: authId, authToken: authToken).buildUsStreetApiClient()
            var error:NSError! = nil
            
            _ = client.sendBatch(batch: self.batch, error: &error)
            
            if let error = error {
                let output = """
                Domain: \(error.domain)
                Error Code: \(error.code)
                Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
                """
                NSLog(output)
                return output
            }
            
            let lookups:[USStreetLookup] = self.batch.allLookups as! [USStreetLookup]
            var output = "Results: \n"
            
            for i in 0..<batch.count() {
                let candidates:[USStreetCandidate] = lookups[i].result
                
                if candidates.count == 0 {
                    return "\nAddress \(i) is invalid\n"
                }
                
                for candidate in candidates {
                    output.append("""
                        Address is valid. (There is at least one candidate)\n\n
                        \nZIP Code: \(candidate.components?.zipCode ?? "")
                        \nCounty: \(candidate.metadata?.countyName ?? "")
                        \nLatitude: \(candidate.metadata?.latitude ?? 0.0)
                        \nLongitude: \(candidate.metadata?.longitude ?? 0.0)
                        """)
                }
                
                output.append("\n******************************\n")
            }
            return output
        }
        return "Uncaught Error"
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
