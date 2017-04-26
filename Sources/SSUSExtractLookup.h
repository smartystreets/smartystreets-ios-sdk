#import <Foundation/Foundation.h>
#import "SSUSExtractResult.h"

/*!
 @class SSUSExtractLookup
 
 @brief The US Extract Lookup class
 
 @description In addition to holding all of the input data for this lookup, this class also<br> will contain the result of the lookup after it comes back from the API.
 
 @see https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields
 */
@interface SSUSExtractLookup : NSObject

@property (nonatomic) SSUSExtractResult *result;
@property (nonatomic) bool addressesHaveLineBreaks;
@property (nonatomic) int addressesPerLine;
@property (nonatomic) NSString *text;

/*!
 @param text is to have addresses extracted out of it for verification
 */
- (instancetype)initWithText:(NSString*)text;
- (void)specifyHtmlInput:(bool)html;
- (void)setAggressive:(bool)aggressive;
- (bool)isHtml;
- (bool)isAggressive;

@end
