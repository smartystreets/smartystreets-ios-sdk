 #import "SSCity.h"

@implementation SSCity

- (instancetype)initWithData:(NSDictionary*)data {
    if (self = [super init]) {
        _city = [data objectForKey:@"city"];
        
        if ([[data objectForKey:@"mailable_city"]boolValue])
            _mailableCity = YES;
        
        _stateAbbreviation = [data objectForKey:@"state_abbreviation"];
        _state = [data objectForKey:@"state"];
    }
    return self;
}

@end
