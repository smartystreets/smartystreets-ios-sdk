#import <Foundation/Foundation.h>
#import "SSSerializer.h"

@interface SSMockDeserializer : NSObject <SSSerializer>

@property (readonly, nonatomic) NSData *payload;

- (instancetype)initWithDeserializedObject:(id)deserialized;

@end
