#import <Foundation/Foundation.h>

@protocol SSLookup;

@interface SSLookup : NSObject

@property (nonatomic, weak) id<SSLookup> delegate;

@end

@protocol SSLookup <NSObject>

@property (nonatomic) NSString *inputId;

- (NSDictionary*)toDictionary;

@end