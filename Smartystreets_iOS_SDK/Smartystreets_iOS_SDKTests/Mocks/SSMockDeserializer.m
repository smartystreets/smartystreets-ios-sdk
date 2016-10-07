#import "SSMockDeserializer.h"

@interface SSMockDeserializer()

@property (readonly, nonatomic) NSArray *deserialized;

@end

@implementation SSMockDeserializer

- (instancetype)initWithDeserializedObject:(NSArray*)deserialized {
    if (self = [super init])
        _deserialized = deserialized;
    return self;
}

- (NSData*)serialize:(NSObject*)obj error:(NSError**)error {
    return [[NSData alloc] init];
}

- (NSArray*)deserialize:(NSData*)payload withClassType:(Class)classType error:(NSError**)error {
    _payload = payload;
    return self.deserialized;
}

@end
