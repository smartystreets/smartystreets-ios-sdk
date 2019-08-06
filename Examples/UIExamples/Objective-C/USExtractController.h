#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface USExtractController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *input;
@property (weak, nonatomic) IBOutlet UITextView *result;

- (IBAction)Search:(UIButton *)sender;
- (NSString*)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
