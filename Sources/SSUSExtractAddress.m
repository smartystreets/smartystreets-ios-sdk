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
        _candidates = dictionary[@"api_output"];
        
        if ([self.candidates isEqual:[NSNull null]])
            _candidates = [NSMutableArray<SSUSStreetCandidate*> new];
        
        _candidates = [self convertToCandidateObjects:dictionary];
    }
    return self;
}

- (NSArray<SSUSStreetCandidate*>*)convertToCandidateObjects:(NSDictionary*)dictionary {
    NSMutableArray<SSUSStreetCandidate*> *candidateObjects = [NSMutableArray<SSUSStreetCandidate*> new];
    
    for (NSDictionary *c in self.candidates)
        [candidateObjects addObject:[[SSUSStreetCandidate alloc] initWithDictionary:c]];
    
    return candidateObjects;
}

- (bool)isVerified {
    return self.verified;
}

@end
