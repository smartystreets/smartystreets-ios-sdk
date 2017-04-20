#import "SSUSExtractAddress.h"

@interface SSUSExtractAddress()

@property (readonly, nonatomic) bool verified;

@end

@implementation SSUSExtractAddress

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _text = dictionary[@"text"];
        
        if ([dictionary[@"verified"] boolValue])
            _verified = YES;
        
        _line = (int)[dictionary[@"line"] integerValue];
        _start = (int)[dictionary[@"start"] integerValue];
        _end = (int)[dictionary[@"end"] integerValue];
        _candidates = [self convertToCandidateObjects:dictionary];
    }
    return self;
}

- (NSArray<SSUSStreetCandidate*>*)convertToCandidateObjects:(NSDictionary*)dictionary {
    NSArray *candidates = [self getCandidatesFromDictionary:dictionary];
    NSMutableArray<SSUSStreetCandidate*> *candidateObjects = [NSMutableArray<SSUSStreetCandidate*> new];
    
    for (NSDictionary *c in candidates)
        [candidateObjects addObject:[[SSUSStreetCandidate alloc] initWithDictionary:c]];
    
    return candidateObjects;
}

- (NSArray*)getCandidatesFromDictionary:(NSDictionary*)dictionary {
    NSArray *candidates = dictionary[@"api_output"];
    if (candidates != nil)
        return candidates;
    else
        return [NSMutableArray<SSUSStreetCandidate*> new];;
}

- (bool)isVerified {
    return self.verified;
}

@end
