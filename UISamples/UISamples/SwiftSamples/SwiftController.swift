import UIKit

class SwiftController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var examplePicker: UIPickerView!
    
    var examples:[String] = ["US ZIP Code API","US Street API","International Street API","US Autocomplete API","US Extract API"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "lines-map")?.draw(in: self.view.bounds)
        let background = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: background!)
        
        self.examplePicker.delegate = self
        self.examplePicker.dataSource = self
        examples = ["US ZIP Code API","US Street API","International Street API","US Autocomplete API","US Extract API"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return examples.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let name = NSAttributedString(string: examples[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            performSegue(withIdentifier: "ZIPCode", sender: self)
        case 1:
            performSegue(withIdentifier: "USStreet", sender: self)
        case 2:
            performSegue(withIdentifier: "International", sender: self)
        case 3:
            performSegue(withIdentifier: "Autocomplete", sender: self)
        case 4:
            performSegue(withIdentifier: "Extract", sender: self)
        default:
            return
        }
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
