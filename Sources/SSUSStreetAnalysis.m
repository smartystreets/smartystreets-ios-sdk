#import "SSUSStreetAnalysis.h"

@implementation SSUSStreetAnalysis

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _dpvMatchCode = dictionary[@"dpv_match_code"];
        _dpvFootnotes = dictionary[@"dpv_footnotes"];
        _cmra = dictionary[@"dpv_cmra"];
        _vacant = dictionary[@"dpv_vacant"];
        _active = dictionary[@"active"];

        if ([dictionary[@"ews_match"] boolValue])
            _isEwsMatch = YES; //deprecated value, refer to Metadata.isEwsMatch

        _footnotes = dictionary[@"footnotes"];
        _lacsLinkCode = dictionary[@"lacslink_code"];
        _lacsLinkIndicator = dictionary[@"lacslink_indicator"];
        
        if ([dictionary[@"suitelink_match"] boolValue])
            _isSuiteLinkMatch = YES;
    }
    return self;
}

@end
