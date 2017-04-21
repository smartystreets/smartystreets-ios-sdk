#import "ViewController.h"

@interface ViewController () {
    NSArray *pickerData;
    NSString *pickerName;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pickerData = @[
                   @"USStreetSingleAddress",
                   @"USStreetMultipleAddresses",
                   @"USStreetLookupsWithMatchStrategy",
                   @"USZipCodeSingleLookup",
                   @"USZipCodeMultipleLookups",
                   @"USAutocomplete",
                   @"USExtract",
                   @"InternationalStreet"];
    pickerName = pickerData[0];
    
    [_submitButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Connect Data
    self.picker.dataSource = self;
    self.picker.delegate = self;
}

- (void)buttonPressed:(UIButton*)button {
    NSString *result = @"";
    if ([pickerName isEqualToString:@"USStreetSingleAddress"]) {
        SSUSStreetSingleAddressExample *example = [[SSUSStreetSingleAddressExample alloc] init];
        result = [example run];
    }
    else if ([pickerName isEqualToString:@"USStreetMultipleAddresses"]) {
        SSUSStreetMultipleLookupsExample *example = [[SSUSStreetMultipleLookupsExample alloc] init];
        result = [example run];
    }
    else if ([pickerName isEqualToString:@"USStreetLookupsWithMatchStrategy"]) {
        SSUSStreetLookupsWithMatchStrategyExamples *example = [[SSUSStreetLookupsWithMatchStrategyExamples alloc] init];
        result = [example run];
    }
    else if ([pickerName isEqualToString:@"USZipCodeSingleLookup"]) {
        SSUSZipCodeSingleLookupExample *example = [[SSUSZipCodeSingleLookupExample alloc] init];
        result = [example run];
    }
    else if ([pickerName isEqualToString:@"USZipCodeMultipleLookups"]) {
        SSUSZipCodeMultipleLookupsExample *example = [[SSUSZipCodeMultipleLookupsExample alloc] init];
        result = [example run];
    }
    else if ([pickerName isEqualToString:@"USAutocomplete"]) {
        SSUSAutocompleteExample *example = [[SSUSAutocompleteExample alloc] init];
        result = [example run];
    }
    else if ([pickerName isEqualToString:@"USExtract"]) {
        SSUSExtractExample *example = [[SSUSExtractExample alloc] init];
        result = [example run];
    }
    else if ([pickerName isEqualToString:@"InternationalStreet"]) {
        SSInternationalStreetExample *example = [[SSInternationalStreetExample alloc] init];
        result = [example run];
    }
    
    self.resultsTextView.text = result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    pickerName = pickerData[row];
}

@end
