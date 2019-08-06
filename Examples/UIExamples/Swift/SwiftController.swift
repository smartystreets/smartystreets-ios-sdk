import UIKit

class SwiftController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var examplePicker: UIPickerView!
    
    var examples:[String] = ["US ZIP Code Single Lookup","US ZIP Code Multiple Lookups","US Street Single Lookup","US Street Multiple Lookups","International Street Lookup","US Autocomplete","US Extract"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.examplePicker.delegate = self
        self.examplePicker.dataSource = self
        examples = ["US ZIP Code Single Lookup","US ZIP Code Multiple Lookups","US Street Single Lookup","US Street Multiple Lookups","International Street Lookup","US Autocomplete","US Extract"]
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return examples[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            performSegue(withIdentifier: "SingleZIP", sender: self)
        case 1:
            performSegue(withIdentifier: "MultipleZIP", sender: self)
        case 2:
            performSegue(withIdentifier: "SingleStreet", sender: self)
        case 3:
            performSegue(withIdentifier: "StreetMultiple", sender: self)
        case 4:
            performSegue(withIdentifier: "InternationalLookup", sender: self)
        case 5:
            performSegue(withIdentifier: "USAutocomplete", sender: self)
        case 6:
            performSegue(withIdentifier: "USExtract", sender: self)
        default:
            return
        }
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
