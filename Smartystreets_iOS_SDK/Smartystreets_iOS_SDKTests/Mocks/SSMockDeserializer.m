#import "SSMockDeserializer.h"

@interface SSMockDeserializer()

@property (readonly, nonatomic) id<NSObject> deserialized;

@end

@implementation SSMockDeserializer

- (instancetype)initWithDeserializedObject:(id<NSObject>)deserialized {
    if (self = [super init])
        _deserialized = deserialized;
    return self;
}

- (NSMutableData*)serialize:(NSObject *)obj {
    return [[NSMutableData alloc] init];
}

- (id)deserialize:(NSMutableData *)payload withClassType:(Class)type error:(NSError**)error {
    _payload = payload;
    return self.deserialized;
}

@end
