#import "SSRequestCapturingSender.h"

@implementation SSRequestCapturingSender

- (SSResponse*)sendRequest:(SSRequest *)request error:(NSError**)error {
    _request = request;
    self.request.urlPrefix = @"http://localhost/?";
    
    NSString *emptyString = @"[]";
    NSData *data = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[SSResponse alloc] initWithStatusCode:200 payload:data];
}

@end
