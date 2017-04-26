#import <Foundation/Foundation.h>
#import "SSUSExtractMetadata.h"
#import "SSUSExtractAddress.h"

/*!
 @class SSUSExtractResult
 
 @brief The US Extract Result class
 
 @see https://smartystreets.com/docs/cloud/us-extract-api#http-response-status
 */
@interface SSUSExtractResult : NSObject

@property (readonly, nonatomic) SSUSExtractMetadata *metadata;
@property (readonly, nonatomic) NSArray<SSUSExtractAddress*> *addresses;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (SSUSExtractAddress*)getAddressAtIndex:(int)index;

@end
