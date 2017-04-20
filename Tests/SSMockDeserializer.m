#import "SSMockDeserializer.h"

@interface SSMockDeserializer()

@property (readonly, nonatomic) id deserialized;

@end

@implementation SSMockDeserializer

- (instancetype)initWithDeserializedObject:(id)deserialized {
    if (self = [super init])
        _deserialized = deserialized;
    return self;
}

- (NSData*)serialize:(id)obj withClassType:(Class)classType error:(NSError**)error {
    return [[NSData alloc] init];
}

- (id)deserialize:(NSData*)payload error:(NSError**)error {
    _payload = payload;
    return self.deserialized;
}

@end
