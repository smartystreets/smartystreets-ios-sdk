#import <Foundation/Foundation.h>

@protocol SSSerializer;

@interface SSSerializer : NSObject

@property (nonatomic, weak) id<SSSerializer> delegate;

@end

@protocol SSSerializer <NSObject>

- (byte[])serialize:(NSObject)obj;
- (<T> T)deserialize:(byte[])payload withClassType:(Class<T>)type;

@end