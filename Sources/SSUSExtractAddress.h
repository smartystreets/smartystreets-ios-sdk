#import <Foundation/Foundation.h>
#import "SSUSStreetCandidate.h"

@interface SSUSExtractAddress : NSObject

@property (readonly, nonatomic) NSString *text;
@property (readonly, nonatomic) int line;
@property (readonly, nonatomic) int start;
@property (readonly, nonatomic) int end;
@property (readonly, nonatomic) NSArray<SSUSStreetCandidate*> *candidates;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (bool)isVerified;

@end
