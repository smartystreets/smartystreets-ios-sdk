#import <Foundation/Foundation.h>
#import "SSInternationalStreetCandidate.h"
#import "SSLanguageMode.h"

@interface SSInternationalStreetLookup : NSObject

@property (nonatomic) NSMutableArray<SSInternationalStreetCandidate*> *result;
@property (nonatomic) NSString *inputId;
@property (nonatomic) NSString *country;
@property (readonly, nonatomic) NSString *geocode;
@property (nonatomic) SSLanguageMode *language;
@property (nonatomic) NSString *freeform;
@property (nonatomic) NSString *address1;
@property (nonatomic) NSString *address2;
@property (nonatomic) NSString *address3;
@property (nonatomic) NSString *address4;
@property (nonatomic) NSString *organization;
@property (nonatomic) NSString *locality;
@property (nonatomic) NSString *administrativeArea;
@property (nonatomic) NSString *postalCode;

- (instancetype)initWithFreeform:(NSString*)freeform withCountry:(NSString*)country;
- (instancetype)initWithAddress1:(NSString*)address1 withPostalCode:(NSString*)postalCode withCountry:(NSString*)country;
- (instancetype)initWithAddress1:(NSString*)address1 withLocality:(NSString*)locality withAdministrativeArea:(NSString*)administrativeArea withCountry:(NSString*)country;
- (BOOL)missingCountry;
- (BOOL)hasFreeform;
- (BOOL)missingAddress1;
- (BOOL)hasPostalCode;
- (BOOL)missingLocalityOrAdministrativeArea;
- (BOOL)fieldIsSet:(NSString*)field;
- (BOOL)fieldIsMissing:(NSString*)field;
- (SSInternationalStreetCandidate*)getResultAtIndex:(int)index;
- (void)enableGeocode:(BOOL)geocode;

@end
