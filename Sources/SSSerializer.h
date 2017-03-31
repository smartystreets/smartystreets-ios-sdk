#import <Foundation/Foundation.h>

@protocol SSSerializer;

@interface SSSerializer : NSObject

@property (nonatomic, weak) id<SSSerializer> delegate;

@end

@protocol SSSerializer <NSObject>

- (NSData*)serialize:(id)obj withClassType:(Class)classType error:(NSError**)error;
- (NSArray*)deserialize:(NSData*)payload error:(NSError**)error;

@end
