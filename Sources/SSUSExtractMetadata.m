#import "SSUSExtractMetadata.h"

@interface SSUSExtractMetadata()

@property (readonly, nonatomic) bool unicode;

@end

@implementation SSUSExtractMetadata

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _lines = (int)[dictionary[@"lines"] integerValue];
        
        if ([dictionary[@"unicode"] boolValue])
            _unicode = YES;
        
        _addressCount = (int)[dictionary[@"address_count"] integerValue];
        _verifiedCount = (int)[dictionary[@"verified_count"] integerValue];
        _bytes = (int)[dictionary[@"bytes"] integerValue];
        _characterCount = (int)[dictionary[@"character_count"] integerValue];
    }
    return self;
}

- (bool)isUnicode {
    return self.unicode;
}

@end
