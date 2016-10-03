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

- (NSMutableData*)serialize:(NSObject*)obj {
    return [[NSMutableData alloc] init];
}

- (NSArray*)deserialize:(NSMutableData*)payload withClassType:(Class)type error:(NSError**)error {
    _payload = payload;
    return self.deserialized;
}

@end
