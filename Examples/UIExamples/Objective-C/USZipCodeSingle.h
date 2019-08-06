#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface USZipCodeSingle : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UITextView *result;

- (IBAction)lookup:(UIButton *)sender;
- (NSString*)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
