#import "SSResult.h"

@interface SSResult()

@property (nonatomic) int inputIndex;
@property (nonatomic) NSMutableArray<SSCity*> *cities;
@property (nonatomic) NSMutableArray<SSZipCode*> *zipCodes;

@end

@implementation SSResult

- (bool)isValid {
    return (self.status == nil && self.reason == nil);
}

- (SSCity*)getCity:(int)index {
    return [self.cities objectAtIndex:index];
}

- (SSZipCode*)getZipCode:(int)index {
    return [self.zipCodes objectAtIndex:index];
}

@end
