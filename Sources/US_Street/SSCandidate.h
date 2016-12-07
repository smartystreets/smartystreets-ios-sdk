#import <Foundation/Foundation.h>
#import "SSAnalysis.h"
#import "SSComponents.h"
#import "SSMetadata.h"

@interface SSCandidate : NSObject

@property (readonly, nonatomic) NSString *inputId;
@property (readonly, nonatomic) int inputIndex;
@property (readonly, nonatomic) int candidateIndex;
@property (readonly, nonatomic) NSString *addressee;
@property (readonly, nonatomic) NSString *deliveryLine1;
@property (readonly, nonatomic) NSString *deliveryLine2;
@property (readonly, nonatomic) NSString *lastline;
@property (readonly, nonatomic) NSString *deliveryPointBarcode;
@property (readonly, nonatomic) SSComponents *components;
@property (readonly, nonatomic) SSMetadata *metadata;
@property (readonly, nonatomic) SSAnalysis *analysis;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (instancetype)initWithInputIndex:(int)inputIndex;

@end
