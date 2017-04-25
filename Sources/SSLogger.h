#import <Foundation/Foundation.h>

@protocol SSLogger;

@interface SSLogger : NSObject

@property (nonatomic, weak) id<SSLogger> delegate;

@end

@protocol SSLogger <NSObject>

- (void)log:(NSString*)message;

@end
