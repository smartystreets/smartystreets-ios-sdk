#import <UIKit/UIKit.h>
#import <sdk/sdk-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjCZIPExample : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UITextField *inputId;
@property (weak, nonatomic) IBOutlet UITextView *results;




- (IBAction)lookup:(UIButton *)sender;
- (NSString*)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
