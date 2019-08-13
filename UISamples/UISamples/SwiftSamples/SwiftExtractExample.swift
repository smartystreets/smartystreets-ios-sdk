import UIKit
import sdk

class SwiftExtractExample: UIViewController {

    @IBOutlet weak var input: UITextView!
    @IBOutlet weak var result: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "lines-map")?.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: background!)
    }
    
    @IBAction func Run(_ sender: Any) {
        result.text = run()
        self.view.endEditing(true)
    }
    
    func run() -> String {
        let client = ClientBuilder(id: "key", hostname: "hostname").buildUsExtractApiClient()
        
        if let text = input.text {
            //            Documentation for input fields can be found at:
            //            https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields
            
            var lookup = USExtractLookup().withText(text: text)
            var error:NSError? = nil
            
            _ = client.sendLookup(lookup: &lookup, error: &error)
            
            let result = lookup.result
            let metadata = result?.metadata
            var output = "Results: "
            output.append("\nFound \(metadata?.addressCount ?? 0)")
            output.append("\n\(metadata?.verifiedCount ?? 0) of them were valid.\n\n")
            
            let addresses = result?.addresses
            
            output.append("Addresses: \n****************************\n")
            
            if let addresses = addresses {
                for address in addresses {
                    print("ADDRESS VERIFIED \(address.verified ?? false)")
                    output.append("\n\"\(address.text ?? "")\"\n")
                    output.append("\nVerified? \(address.isVerified() ? "YES" : "NO")")
                    if address.candidates?.count ?? 0 > 0 {
                        output.append("\nMatches")
                        
                        for candidate in address.candidates! {
                            output.append("\n\(candidate.deliveryLine1 ?? "")")
                            output.append("\n\(candidate.lastline ?? "")\n")
                        }
                    } else {
                        output.append("\n")
                    }
                    output.append("****************************\n")
                }
            }
            return output
        }
        return "Blank input"
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
