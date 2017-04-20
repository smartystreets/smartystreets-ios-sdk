#import <Foundation/Foundation.h>
#import "SSUSExtractMetadata.h"
#import "SSUSExtractAddress.h"

@interface SSUSExtractResult : NSObject

@property (readonly, nonatomic) SSUSExtractMetadata *metadata;
@property (readonly, nonatomic) NSArray<SSUSExtractAddress*> *addresses;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (SSUSExtractAddress*)getAddressAtIndex:(int)index;

@end
