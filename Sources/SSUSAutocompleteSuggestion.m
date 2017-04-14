#import "SSUSAutocompleteSuggestion.h"

@implementation SSUSAutocompleteSuggestion

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _text = dictionary[@"text"];
        _streetLine = dictionary[@"street_line"];
        _city = dictionary[@"city"];
        _state = dictionary[@"state"];
    }
    return self;
}

@end
