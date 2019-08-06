#import <UIKit/UIKit.h>
#import <sdk/sdk-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjectiveCExtractExample : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *input;
@property (weak, nonatomic) IBOutlet UITextView *result;

- (IBAction)Search:(UIButton *)sender;
- (NSString*)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
