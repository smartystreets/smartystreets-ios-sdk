#import <UIKit/UIKit.h>
#import "SSZipCodeSingleLookupExample.h"
#import "SSZipCodeMultipleLookupsExample.h"
#import "SSUSStreetSingleAddressExample.h"
#import "SSUSStreetMultipleLookupsExample.h"
#import "SSUSStreetLookupsWithMatchStrategyExamples.h"

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;


@end

