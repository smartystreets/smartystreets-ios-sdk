#import <Foundation/Foundation.h>
#import "SSUSExtractResult.h"

@interface SSUSExtractLookup : NSObject

@property (nonatomic) SSUSExtractResult *result;
@property (nonatomic) bool addressesHaveLineBreaks;
@property (nonatomic) int addressesPerLine;
@property (nonatomic) NSString *text;

- (instancetype)initWithText:(NSString*)text;
- (void)specifyHtmlInput:(bool)html;
- (void)setAggressive:(bool)aggressive;
- (bool)isHtml;
- (bool)isAggressive;

@end
