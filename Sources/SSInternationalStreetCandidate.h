#import <Foundation/Foundation.h>
#import "SSInternationalStreetComponents.h"
#import "SSInternationalStreetMetadata.h"
#import "SSInternationalStreetAnalysis.h"

/*!
 @class SSInternationalStreetCandidate
 
 @brief The International Street Candidate class
 
 @description A candidate is a possible match for an address that was submitted.<br> A lookup can have multiple candidates if the address was ambiguous.
 
 @see https://smartystreets.com/docs/cloud/international-street-api#root
 */
@interface SSInternationalStreetCandidate : NSObject

@property (readonly, nonatomic) NSString *organization;
@property (readonly, nonatomic) NSString *address1;
@property (readonly, nonatomic) NSString *address2;
@property (readonly, nonatomic) NSString *address3;
@property (readonly, nonatomic) NSString *address4;
@property (readonly, nonatomic) NSString *address5;
@property (readonly, nonatomic) NSString *address6;
@property (readonly, nonatomic) NSString *address7;
@property (readonly, nonatomic) NSString *address8;
@property (readonly, nonatomic) NSString *address9;
@property (readonly, nonatomic) NSString *address10;
@property (readonly, nonatomic) NSString *address11;
@property (readonly, nonatomic) NSString *address12;
@property (readonly, nonatomic) SSInternationalStreetComponents *components;
@property (readonly, nonatomic) SSInternationalStreetMetadata *metadata;
@property (readonly, nonatomic) SSInternationalStreetAnalysis *analysis;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
