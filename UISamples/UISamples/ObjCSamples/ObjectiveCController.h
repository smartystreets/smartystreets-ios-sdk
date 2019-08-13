#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjectiveCController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (readonly, nonatomic) NSArray *examples;
@property (weak, nonatomic) IBOutlet UIPickerView *examplesPicker;
- (IBAction)Return:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
