#import <Foundation/Foundation.h>

@protocol SSSleeper;

@interface SSSleeper : NSObject

@property (nonatomic, weak) id<SSSleeper> delegate;

@end

@protocol SSSleeper <NSObject>

- (void)sleep:(int)seconds;

@end
