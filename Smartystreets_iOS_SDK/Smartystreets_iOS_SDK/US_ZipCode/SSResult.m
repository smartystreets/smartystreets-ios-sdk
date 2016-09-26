#import "SSResult.h"

@implementation SSResult

- (instancetype)initWithData:(NSDictionary*)data {
    if (self = [super init]) {
        _status = [data objectForKey:@"status"];
        _reason = [data objectForKey:@"reason"];
        _inputIndex = (int)[[data objectForKey:@"input_index"] integerValue];
        _cities = [NSMutableArray<SSCity*> new];
        _zipCodes = [NSMutableArray<SSZipCode*> new];
        
        for (SSCity *city in [data objectForKey:@"city_states"]) {
            [_cities addObject:city];
        }
        
        for (SSZipCode *zipCode in [data objectForKey:@"zipcodes"]) {
            [_zipCodes addObject:zipCode];
        }
        
//        SSCity *city = [[SSCity alloc] initWithData:data];
//        SSZipCode *zipcode = [[SSZipCode alloc] initWithData:data];
//        
//        [_cities addObject:city];
//        [_zipCodes addObject:zipcode];
    }
    return self;
}

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
