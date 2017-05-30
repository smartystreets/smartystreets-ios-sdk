#import "SSRequestCapturingSender.h"

@implementation SSRequestCapturingSender

- (SSSmartyResponse*)sendRequest:(SSSmartyRequest*)request error:(NSError**)error {
    _request = request;
    self.request.urlPrefix = @"http://localhost/?";
    
    NSString *emptyString = @"[]";
    NSData *data = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[SSSmartyResponse alloc] initWithStatusCode:200 payload:data];
}

@end
