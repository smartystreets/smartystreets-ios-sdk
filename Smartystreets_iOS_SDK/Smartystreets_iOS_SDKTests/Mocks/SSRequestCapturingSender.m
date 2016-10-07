#import "SSRequestCapturingSender.h"

@implementation SSRequestCapturingSender

- (SSResponse*)sendRequest:(SSRequest *)request withError:(NSError**)error {
    _request = request;
    
    NSString *emptyString = @"[]";
    NSData *data = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[SSResponse alloc] initWithStatusCode:200 payload:data];
}

@end
