#import "SSMockSerializer.h"

@interface SSMockSerializer()

@property (readonly, nonatomic) NSMutableData *bytes;

@end

@implementation SSMockSerializer

- (instancetype)initWithBytes:(NSMutableData*)bytes {
    if (self = [super init])
        _bytes = bytes;
    return self;
}


- (NSMutableData*)serialize:(NSObject*)obj {
    return self.bytes;
}

- (NSArray*)deserialize:(NSMutableData *)payload withClassType:(Class)type error:(NSError**)error {
    return nil;
}

@end
