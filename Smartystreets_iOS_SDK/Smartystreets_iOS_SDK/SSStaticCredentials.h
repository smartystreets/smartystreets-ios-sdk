#import <Foundation/Foundation.h>
#import "SSCredentials.h"

@interface SSStaticCredentials : NSObject <SSCredentials>

@property (nonatomic) NSString *authId;
@property (nonatomic) NSString *authToken;

- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken;

@end
