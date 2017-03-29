#import <Foundation/Foundation.h>
#import "SSLookup.h"
#import "SSUSStreetCandidate.h"
#import "SSSmartyErrors.h"

extern NSString *const kSSStrict;
extern NSString *const kSSRange;
extern NSString *const kSSInvalid;

@interface SSUSStreetLookup : NSObject <SSLookup>

@property (readonly, nonatomic) NSMutableArray<SSUSStreetCandidate*> *result;
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

- (instancetype)initWithFreeformAddress:(NSString*)freeformAddress;
- (void)addToResult:(SSUSStreetCandidate*)newCandidate;
- (SSUSStreetCandidate*)getResultAtIndex:(int)index;
- (void)setMaxCandidates:(int)maxCandidates error:(NSError**)error;

@end
