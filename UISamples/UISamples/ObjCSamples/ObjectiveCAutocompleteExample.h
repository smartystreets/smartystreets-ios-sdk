#import <UIKit/UIKit.h>
#import <sdk/sdk-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjectiveCAutocompleteExample : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *prefer;
@property (weak, nonatomic) IBOutlet UITextField *prefix;
@property (weak, nonatomic) IBOutlet UITextView *result;


- (IBAction)addressChanged:(UITextField *)sender;
- (NSString*)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
