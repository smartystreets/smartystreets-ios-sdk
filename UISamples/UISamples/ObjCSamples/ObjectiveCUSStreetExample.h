#import <UIKit/UIKit.h>
#import <sdk/sdk-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjectiveCUSStreetExample : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *freeform;
@property (weak, nonatomic) IBOutlet UITextField *street;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextView *result;

@property (readonly, nonatomic) USStreetBatch *batch;
- (IBAction)search:(UIButton *)sender;
- (IBAction)add:(UIButton *)sender;
- (NSString *)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
