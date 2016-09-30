#import "SSMockDeserializer.h"

@interface SSMockDeserializer()

@property (readonly, nonatomic) NSMutableArray *deserialized;

@end

@implementation SSMockDeserializer

- (instancetype)initWithDeserializedObject:(NSMutableArray*)deserialized {
    if (self = [super init])
        _deserialized = deserialized;
    return self;
}

- (NSMutableData*)serialize:(NSObject *)obj {
    return [[NSMutableData alloc] init];
}

- (NSMutableArray*)deserialize:(NSMutableData *)payload withClassType:(Class)type error:(NSError**)error {
    _payload = payload;
    return self.deserialized;
}

@end
