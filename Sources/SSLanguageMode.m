#import "SSLanguageMode.h"

NSString *const kSSNative = @"native";
NSString *const kSSLatin = @"latin";

@implementation SSLanguageMode

- (instancetype)initWithName:(NSString*)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

@end
