#import "SSMockCrashingSender.h"

int const kStatusCode = 200;

@implementation SSMockCrashingSender

- (instancetype)init {
    if (self = [super init])
        _sendCount = 0;
    return self;
}

- (SSSmartyResponse*)sendRequest:(SSSmartyRequest*)request error:(NSError**)error {
    _sendCount++;
    
    NSDictionary *details;
    
    if ([request.getUrl containsString:@"RetryThreeTimes"]) {
        if (self.sendCount <= 3) {
            details = @{NSLocalizedDescriptionKey: @"You need to retry"};
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[*error code] userInfo:details];
            return nil;
        }
    }
    else if ([request.getUrl containsString:@"RetryMaxTimes"]) {
        details = @{NSLocalizedDescriptionKey: @"Retrying won't help"};
        *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[*error code] userInfo:details];
        return nil;
    }
    else if ([request.getUrl containsString:@"RetryFifteenTimes"]) {
        if (self.sendCount <= 14) {
            details = @{NSLocalizedDescriptionKey: @"You need to retry"};
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[*error code] userInfo:details];
            return nil;
        }
    }
    
    return [[SSSmartyResponse alloc] initWithStatusCode:kStatusCode payload:[[NSMutableData alloc] init]];
}

@end
