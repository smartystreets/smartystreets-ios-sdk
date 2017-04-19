#import "SSGeolocateType.h"

NSString *const kSSGeolocateTypeCity = @"city";
NSString *const kSSGeolocateTypeState = @"state";
NSObject *const kSSGeolocateTypeNone = nil;

@implementation SSGeolocateType

- (instancetype)initWithName:(NSString*)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

@end
