#import "ObjectiveCController.h"

@interface ObjectiveCController ()

@end

@implementation ObjectiveCController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"lines-map"] drawInRect:self.view.bounds];
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
    
    _examples = [NSArray arrayWithObjects: @"US ZIP API", @"US Street API", @"International Street API", @"US Autocomplete API", @"US Extract API", nil];
    _examplesPicker.delegate = self;
    _examplesPicker.dataSource = self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _examples.count;
}

- (NSAttributedString *)pickerView:(UIPickerView *)thePickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSAttributedString *name = [[NSAttributedString alloc] initWithString:_examples[row] attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (row) {
        case 0:
            [self performSegueWithIdentifier:@"ZIP API" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"US Street API" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"International API" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"Autocomplete API" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"Extract API" sender:self];
            break;
        default:
            break;
    }
}

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
