#import <Foundation/Foundation.h>
#import "SSInternationalStreetComponents.h"
#import "SSInternationalStreetMetadata.h"
#import "SSInternationalStreetAnalysis.h"
#import "SSInternationalStreetRootLevel.h"

/*!
 @class SSInternationalStreetCandidate
 
 @brief The International Street Candidate class
 
 @description A candidate is a possible match for an address that was submitted.<br> A lookup can have multiple candidates if the address was ambiguous.
 
 @see https://smartystreets.com/docs/cloud/international-street-api#root
 */
@interface SSInternationalStreetCandidate : SSInternationalStreetRootLevel
@property (readonly, nonatomic) SSInternationalStreetComponents *components;
@property (readonly, nonatomic) SSInternationalStreetMetadata *metadata;
@property (readonly, nonatomic) SSInternationalStreetAnalysis *analysis;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
