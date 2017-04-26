#import <Foundation/Foundation.h>

extern NSString *const kSSNative;
extern NSString *const kSSLatin;

/*!
 @class SSLanguageMode
 
 @brief The Language Mode class
 
 @description When not set, the output language will match the language of the input values. When set to <b>NATIVE</b> the results will always be in the language of the output country. When set to <b>LATIN</b> the results<br> will always be provided using a Latin character set.
 */
@interface SSLanguageMode : NSObject

@property(readonly, nonatomic) NSString *name;

- (instancetype)initWithName:(NSString*)name;

@end
