#import <Foundation/Foundation.h>

@protocol SSSerializer <NSObject>

- (byte[])serialize:(NSObject)obj;
- (<T> T)deserialize:(byte[])payload withClassType:(Class<T>)type;

@end