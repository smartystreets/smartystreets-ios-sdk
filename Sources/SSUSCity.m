 #import "SSUSCity.h"

@implementation SSUSCity

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _city = dictionary[@"city"];
        
        if ([dictionary[@"mailable_city"] boolValue])
            _mailableCity = YES;
        
        _stateAbbreviation = dictionary[@"state_abbreviation"];
        _state = dictionary[@"state"];
    }
    return self;
}

@end
