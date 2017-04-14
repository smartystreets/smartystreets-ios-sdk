#import "SSInternationalStreetLookup.h"

@implementation SSInternationalStreetLookup

- (instancetype)init {
    if (self = [super init]) {
        _result = [[NSMutableArray<SSInternationalStreetCandidate*> alloc] init];
    }
    return self;
}

- (instancetype)initWithFreeform:(NSString*)freeform withCountry:(NSString*)country {
    if (self = [[super self] init]) {
        _freeform = freeform;
        _country = country;
    }
    return self;
}

- (instancetype)initWithAddress1:(NSString*)address1 withPostalCode:(NSString*)postalCode withCountry:(NSString*)country {
    if (self = [[super self] init]) {
        _address1 = address1;
        _postalCode = postalCode;
        _country = country;
    }
    return self;
}

- (instancetype)initWithAddress1:(NSString*)address1 withLocality:(NSString*)locality withAdministrativeArea:(NSString*)administrativeArea withCountry:(NSString*)country {
    if (self = [[super self] init]) {
        _address1 = address1;
        _locality = locality;
        _administrativeArea = administrativeArea;
        _country = country;
    }
    return self;
}

- (BOOL)missingCountry {
    return [self fieldIsMissing:self.country];
}

- (BOOL)hasFreeform {
    return [self fieldIsSet:[self freeform]];
}

- (BOOL)missingAddress1 {
    return [self fieldIsMissing:self.address1];
}

- (BOOL)hasPostalCode {
    return [self fieldIsSet:self.postalCode];
}

- (BOOL)missingLocalityOrAdministrativeArea {
    return [self fieldIsMissing:self.locality] || [self fieldIsMissing:self.administrativeArea];
}

- (BOOL)fieldIsSet:(NSString*)field {
    return ![self fieldIsMissing:field];
}

- (BOOL)fieldIsMissing:(NSString*)field {
    return (field == nil || [field length] == 0);
}

- (SSInternationalStreetCandidate*)getResultAtIndex:(int)index {
    return [self.result objectAtIndex:index];
}

- (void)enableGeocode:(BOOL)geocode {
    if (geocode)
        _geocode = @"true";
    else
        _geocode = @"false";
}


@end
