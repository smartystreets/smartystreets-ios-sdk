#import "SSUSExtractLookup.h"

@interface SSUSExtractLookup()

@property (nonatomic) bool html;
@property (nonatomic) bool aggressive;

@end

@implementation SSUSExtractLookup

- (instancetype)init {
    if (self = [super init]) {
        _result = [[SSUSExtractResult alloc] init];
        _aggressive = NO;
        _addressesHaveLineBreaks = YES;
        _addressesPerLine = 0;
    }
    return self;
}

- (instancetype)initWithText:(NSString*)text {
    if (self = [[super self] init]) {
        _text = text;
    }
    return self;
}

- (void)specifyHtmlInput:(bool)html {
    _html = html;
}

- (void)setAggressive:(bool)aggressive {
    _aggressive = aggressive;
}

- (bool)isHtml {
    return self.html;
}

- (bool)isAggressive {
    return self.aggressive;
}

@end
