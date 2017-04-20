#import "SSMockSerializer.h"

@interface SSMockSerializer()

@property (readonly, nonatomic) NSData *bytes;
@property (readonly, nonatomic) NSObject *result;

@end

@implementation SSMockSerializer

- (instancetype)initWithBytes:(NSData*)bytes {
    if (self = [super init])
        _bytes = bytes;
    return self;
}

- (instancetype)initWithResult:(NSObject*)result {
    if (self = [super init])
        _result = result;
    return self;
}


- (NSData*)serialize:(id)obj withClassType:(Class)classType error:(NSError**)error {
    return self.bytes;
}

- (id)deserialize:(NSData *)payload error:(NSError**)error {
    return nil;
}

@end
