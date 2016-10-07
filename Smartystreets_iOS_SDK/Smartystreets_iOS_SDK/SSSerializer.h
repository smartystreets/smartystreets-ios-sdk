#import <Foundation/Foundation.h>

@protocol SSSerializer;

@interface SSSerializer : NSObject

@property (nonatomic, weak) id<SSSerializer> delegate;

@end

@protocol SSSerializer <NSObject>

- (NSData*)serialize:(NSObject*)obj error:(NSError**)error;
- (NSArray*)deserialize:(NSData*)payload withClassType:(Class)classType error:(NSError**)error;

@end