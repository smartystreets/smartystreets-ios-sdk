#import <Foundation/Foundation.h>

@protocol SSSmartyLogger;

@interface SSSmartyLogger : NSObject

@property (nonatomic, weak) id<SSSmartyLogger> delegate;

@end

@protocol SSSmartyLogger <NSObject>

- (void)log:(NSString*)message;

@end
