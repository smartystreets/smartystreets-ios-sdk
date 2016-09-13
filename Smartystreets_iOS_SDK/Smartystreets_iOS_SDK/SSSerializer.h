#import <Foundation/Foundation.h>

@protocol SSSerializer;

@interface SSSerializer : NSObject

@property (nonatomic, weak) id<SSSerializer> delegate;

@end

@protocol SSSerializer <NSObject>

- (NSMutableData*)serialize:(NSObject*)obj;
- (id)deserialize:(NSMutableData*)payload withClassType:(Class)type;

@end