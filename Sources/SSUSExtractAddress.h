#import <Foundation/Foundation.h>
#import "SSUSStreetCandidate.h"

/*!
 @class SSUSExtractAddress
 
 @brief The US Extract Address class
 
 @see https://smartystreets.com/docs/cloud/us-extract-api#http-response-status
 */
@interface SSUSExtractAddress : NSObject

@property (readonly, nonatomic) NSString *text;
@property (readonly, nonatomic) int line;
@property (readonly, nonatomic) int start;
@property (readonly, nonatomic) int end;
@property (readonly, nonatomic) NSArray<SSUSStreetCandidate*> *candidates;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (bool)isVerified;

@end
