#import "SSCandidate.h"

@interface SSCandidate()

@property (nonatomic) int inputIndex;
@property (nonatomic) int candidateIndex;
@property (nonatomic) NSString *addressee;
@property (nonatomic) NSString *deliveryLine1;
@property (nonatomic) NSString *deliveryLine2;
@property (nonatomic) NSString *lastline;
@property (nonatomic) NSString *deliveryPointBarcode;
@property (nonatomic) SSComponents *components;
@property (nonatomic) SSMetadata *metadata;
@property (nonatomic) SSAnalysis *analysis;

@end

@implementation SSCandidate

- (instancetype)initWithInputIndex:(int)inputIndex {
    if (self = [super init])
        _inputIndex = inputIndex;
    return self;
}

@end
