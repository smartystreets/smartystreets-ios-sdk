//#import "ObjectiveCViewController.h"
//
//@interface ObjectiveCViewController ()
//
//@end
//
//@implementation ObjectiveCViewController
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    _examples = [NSArray arrayWithObjects: @"US ZIP Code Single Lookup",@"US ZIP Code Multiple Lookups",@"US Street Single Lookup",@"US Street Multiple Lookups",@"International Street Lookup",@"US Autocomplete",@"US Extract", nil];
//    
//    _examplesPicker.delegate = self;
//    _examplesPicker.delegate = self;
//}
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
//    return 1;
//}
//
//- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    return _examples.count;
//}
//
//- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return _examples[row];
//}
//
//- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    switch (row) {
//        case 0:
//            [self performSegueWithIdentifier:@"ZipCodeSingle" sender:self];
//            break;
//        case 1:
//            [self performSegueWithIdentifier:@"ZipCodeMultiple" sender:self];
//            break;
//        case 2:
//            [self performSegueWithIdentifier:@"USStreetSingle" sender:self];
//            break;
//        case 3:
//            [self performSegueWithIdentifier:@"USStreetMultiple" sender:self];
//            break;
//        case 4:
//            [self performSegueWithIdentifier:@"International" sender:self];
//            break;
//        case 5:
//            [self performSegueWithIdentifier:@"Autocomplete" sender:self];
//            break;
//        case 6:
//            [self performSegueWithIdentifier:@"Extract" sender:self];
//            break;
//        default:
//            break;
//    }
//}
//
//- (IBAction)Return:(UIButton *)sender {
//    [self dismissViewControllerAnimated:true completion:nil];
//}
//
//@end
