#import <UIKit/UIKit.h>
@class USStreetBatch;

NS_ASSUME_NONNULL_BEGIN

@interface USStreetMultiple : UIViewController

@property (readonly, nonatomic) USStreetBatch *batch;
@property (weak, nonatomic) IBOutlet UITextField *street;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *inputId;
@property (weak, nonatomic) IBOutlet UITextField *freeform;
@property (weak, nonatomic) IBOutlet UITextView *result;

- (IBAction)search:(UIButton *)sender;
- (IBAction)add:(UIButton *)sender;
- (NSString *)run;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
