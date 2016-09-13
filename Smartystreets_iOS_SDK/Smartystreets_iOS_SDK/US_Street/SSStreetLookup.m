#import "SSStreetLookup.h"

@interface SSStreetLookup()

@property (nonatomic) NSMutableArray<SSCandidate*> *result;
@property (nonatomic) int maxCandidates;

@end

@implementation SSStreetLookup

- (instancetype)init {
    if (self = [super init]) {
        _maxCandidates = 1;
        _result = [[NSMutableArray<SSCandidate*> alloc] init];
    }
    return self;
}

- (instancetype)initWithFreeformAddress:(NSString*)freeformAddress {
    if (self = [[super self] init])
        _street = freeformAddress;
    return self;
}

- (void)addToResult:(SSCandidate*)newCandidate {
    [self.result addObject:newCandidate];
}

- (void)setMaxCandidates:(int)maxCandidates error:(NSError**)error {
    if (maxCandidates > 0)
        _maxCandidates = maxCandidates;
    
    NSDictionary *details = @{NSLocalizedDescriptionKey: @"Max candidates must be a positive integer."};
    *error = [NSError errorWithDomain:NSCocoaErrorDomain code:nil userInfo:details]; //TODO: what is the error code?
}

@end
