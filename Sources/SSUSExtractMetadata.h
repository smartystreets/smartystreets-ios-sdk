#import <Foundation/Foundation.h>

@interface SSUSExtractMetadata : NSObject

@property (readonly, nonatomic) int lines;
@property (readonly, nonatomic) int addressCount;
@property (readonly, nonatomic) int verifiedCount;
@property (readonly, nonatomic) int bytes;
@property (readonly, nonatomic) int characterCount;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (bool)isUnicode;

@end
