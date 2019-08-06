#import <UIKit/UIKit.h>
@class USZipCodeBatch;

NS_ASSUME_NONNULL_BEGIN

@interface USZipCodeMultiple : UIViewController

@property (readonly, nonatomic) USZipCodeBatch *batch;

@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UITextField *inputId;
@property (weak, nonatomic) IBOutlet UITextView *results;



- (IBAction)lookup:(UIButton *)sender;
- (IBAction)add:(UIButton *)sender;
- (NSString*)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
