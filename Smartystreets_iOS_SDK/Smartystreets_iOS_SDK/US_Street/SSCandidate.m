#import "SSCandidate.h"

@implementation SSCandidate

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _inputId = dictionary[@"input_id"];
        _inputIndex = (int)[dictionary[@"input_index"] integerValue];
        _candidateIndex = (int)[dictionary[@"candidate_index"] integerValue];
        _addressee = dictionary[@"addressee"];
        _deliveryLine1 = dictionary[@"delivery_line_1"];
        _deliveryLine2 = dictionary[@"delivery_line_2"];
        _lastline = dictionary[@"last_line"];
        _deliveryPointBarcode = dictionary[@"delivery_point_barcode"];
        NSDictionary *components = dictionary[@"components"];
        NSDictionary *metadata = dictionary[@"metadata"];
        NSDictionary *analysis = dictionary[@"analysis"];
        
        if (components != nil)
            _components = [[SSComponents alloc] initWithDictionary:components];
        
        if (metadata != nil)
            _metadata = [[SSMetadata alloc] initWithDictionary:metadata];
        
        if (analysis != nil)
            _analysis = [[SSAnalysis alloc] initWithDictionary:analysis];
    }
    
    return self;
}

- (instancetype)initWithInputIndex:(int)inputIndex {
    if (self = [super init])
        _inputIndex = inputIndex;
    return self;
}

@end
