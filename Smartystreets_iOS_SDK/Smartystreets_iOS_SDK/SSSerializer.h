#import <Foundation/Foundation.h>

@protocol SSSerializer;

@interface SSSerializer : NSObject

@property (nonatomic, weak) id<SSSerializer> delegate;

@end

@protocol SSSerializer <NSObject>

- (NSMutableData*)serialize:(NSObject*)obj;
- (NSArray*)deserialize:(NSMutableData*)payload withClassType:(Class)type error:(NSError**)error;

@end