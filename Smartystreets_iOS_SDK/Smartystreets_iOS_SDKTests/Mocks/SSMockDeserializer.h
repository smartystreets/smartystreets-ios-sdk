#import <Foundation/Foundation.h>
#import "SSSerializer.h"

@interface SSMockDeserializer : NSObject <SSSerializer>

@property (readonly, nonatomic) NSMutableData *payload;

- (instancetype)initWithDeserializedObject:(NSArray*)deserialized;

@end
