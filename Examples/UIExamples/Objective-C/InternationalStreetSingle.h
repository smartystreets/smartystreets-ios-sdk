#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InternationalStreetSingle : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *country;
@property (weak, nonatomic) IBOutlet UITextField *freeform;
@property (weak, nonatomic) IBOutlet UITextView *result;

- (IBAction)search:(UIButton *)sender;
- (NSString*)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
