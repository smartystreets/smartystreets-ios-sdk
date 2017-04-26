#import <Foundation/Foundation.h>
#import "SSLookup.h"
#import "SSUSStreetCandidate.h"
#import "SSSmartyErrors.h"

extern NSString *const kSSStrict;
extern NSString *const kSSRange;
extern NSString *const kSSInvalid;

/*!
 @class SSUSStreetLookup
 
 @brief The US Street Lookup class
 
 @description In addition to holding all of the input data for this lookup, this class also will contain the result of the lookup after it comes back from the API.
 
 @see https://smartystreets.com/docs/cloud/us-street-api#input-fields
 */
@interface SSUSStreetLookup : NSObject <SSLookup>

@property (nonatomic) NSMutableArray<SSUSStreetCandidate*> *result;
@property (nonatomic) NSString *inputId;
@property (nonatomic) NSString *street;
@property (nonatomic) NSString *street2;
@property (nonatomic) NSString *secondary;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zipCode;
@property (nonatomic) NSString *lastline;
@property (nonatomic) NSString *addressee;
@property (nonatomic) NSString *urbanization;
@property (readonly, nonatomic) int maxCandidates;
@property (nonatomic) NSString *matchStrategy;

/*!
 @brief This constructor accepts a freeform address. That means the whole address is in one string.
 */
- (instancetype)initWithFreeformAddress:(NSString*)freeformAddress;
- (void)addToResult:(SSUSStreetCandidate*)newCandidate;
- (SSUSStreetCandidate*)getResultAtIndex:(int)index;

/*!
 @brief Sets the maximum number of valid addresses returned when the input is ambiguous.
 
 @param maxCandidates Defaults to 1. Must be an integer between 1 and 10, inclusive.
 */
- (void)setMaxCandidates:(int)maxCandidates error:(NSError**)error;

@end
