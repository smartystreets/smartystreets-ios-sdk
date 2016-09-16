#import <Foundation/Foundation.h>
#import "SSSerializer.h"

@interface SSMockDeserializer : NSObject <SSSerializer>

@property (readonly, nonnull) NSMutableData *payload;

- (instancetype)initWithDeserializedObject:(id<NSObject>)deserialized;

@end
