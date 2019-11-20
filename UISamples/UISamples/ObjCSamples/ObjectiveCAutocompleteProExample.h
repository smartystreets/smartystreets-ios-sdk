#import <UIKit/UIKit.h>
#import <sdk/sdk-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjectiveCAutocompleteProExample : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *cityFilter;
@property (weak, nonatomic) IBOutlet UITextField *stateFilter;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeFilter;
@property (weak, nonatomic) IBOutlet UITextField *preferCity;
@property (weak, nonatomic) IBOutlet UITextField *preferState;
@property (weak, nonatomic) IBOutlet UITextField *preferZipcode;
@property (weak, nonatomic) IBOutlet UITextField *search;
@property (weak, nonatomic) IBOutlet UITextView *result;


- (IBAction)addressChanged:(UITextField *)sender;
- (NSString*)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
