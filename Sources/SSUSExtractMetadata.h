#import <Foundation/Foundation.h>

/*!
 @class SSUSExtractMetadata
 
 @brief The US Extract Metadata class
 
 @see https://smartystreets.com/docs/cloud/us-extract-api#http-response-status
 */
@interface SSUSExtractMetadata : NSObject

@property (readonly, nonatomic) int lines;
@property (readonly, nonatomic) int addressCount;
@property (readonly, nonatomic) int verifiedCount;
@property (readonly, nonatomic) int bytes;
@property (readonly, nonatomic) int characterCount;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (bool)isUnicode;

@end
