#import <Foundation/Foundation.h>
#import "SSInternationalStreetCandidate.h"
#import "SSLanguageMode.h"

/*!
 @class SSInternationalStreetLookup
 
 @brief The International Street Lookup class
 
 @description In addition to holding all of the input data for this lookup, this class also<br> will contain the result of the lookup after it comes back from the API. <p><b>Note: </b><i>Lookups must have certain required fields set with non-blank values. <br> These can be found at the URL below.</i></p>
 
 @see https://smartystreets.com/docs/cloud/international-street-api#http-input-fields
 */
@interface SSInternationalStreetLookup : NSObject

@property (nonatomic) NSMutableArray<SSInternationalStreetCandidate*> *result;
@property (nonatomic) NSString *inputId;
@property (nonatomic) NSString *country;
@property (readonly, nonatomic) NSString *geocode;

/*!
 @description When not set, the output language will match the language of the input values. When set to <b>NATIVE</b> the<br> results will always be in the language of the output country. When set to <b>LATIN</b> the results<br> will always be provided using a Latin character set.
 */
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

/*!
 @param geocode Disabled by default. Set to <b>true</b> to enable.
 */
- (void)enableGeocode:(BOOL)geocode;

@end
