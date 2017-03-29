#import <Foundation/Foundation.h>
#import "SSUSStreetAnalysis.h"
#import "SSUSStreetComponents.h"
#import "SSUSStreetMetadata.h"

@interface SSUSStreetCandidate : NSObject

@property (readonly, nonatomic) NSString *inputId;
@property (readonly, nonatomic) int inputIndex;
@property (readonly, nonatomic) int candidateIndex;
@property (readonly, nonatomic) NSString *addressee;
@property (readonly, nonatomic) NSString *deliveryLine1;
@property (readonly, nonatomic) NSString *deliveryLine2;
@property (readonly, nonatomic) NSString *lastline;
@property (readonly, nonatomic) NSString *deliveryPointBarcode;
@property (readonly, nonatomic) SSUSStreetComponents *components;
@property (readonly, nonatomic) SSUSStreetMetadata *metadata;
@property (readonly, nonatomic) SSUSStreetAnalysis *analysis;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (instancetype)initWithInputIndex:(int)inputIndex;

@end
