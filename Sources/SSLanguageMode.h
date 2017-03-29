#import <Foundation/Foundation.h>

extern NSString *const kSSNative;
extern NSString *const kSSLatin;

@interface SSLanguageMode : NSObject

@property(readonly, nonatomic) NSString *name;

- (instancetype)initWithName:(NSString*)name;

@end
