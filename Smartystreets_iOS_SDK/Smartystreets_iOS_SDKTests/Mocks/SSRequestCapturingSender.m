#import "SSRequestCapturingSender.h"

@implementation SSRequestCapturingSender

- (SSResponse*)sendRequest:(SSRequest *)request withError:(NSError**)error {
    _request = request;
    
    NSString *emptyString = @"[]";
    NSData *data = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithData:data];
    
    return [[SSResponse alloc] initWithStatusCode:200 payload:mutableData];
}

@end
