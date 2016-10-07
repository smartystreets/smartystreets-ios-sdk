#import "SSMockSerializer.h"

@interface SSMockSerializer()

@property (readonly, nonatomic) NSData *bytes;

@end

@implementation SSMockSerializer

- (instancetype)initWithBytes:(NSData*)bytes {
    if (self = [super init])
        _bytes = bytes;
    return self;
}


- (NSData*)serialize:(NSObject*)obj error:(NSError**)error {
    return self.bytes;
}

- (NSArray*)deserialize:(NSData *)payload withClassType:(Class)classType error:(NSError**)error {
    return nil;
}

@end
