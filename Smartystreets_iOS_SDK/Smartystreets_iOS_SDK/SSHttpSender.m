#import "SSHttpSender.h"

@interface SSHttpSender()
    
@property (nonatomic) int maxTimeout;
//@property (nonatomic) HttpTransport transport; //TODO: Java uses this line. figure out what to do for Objective-C

@end

@implementation SSHttpSender

- (instancetype)init {
    if (self = [super init]) {
        _maxTimeout = 10000;
//        _transport = [[NetHttpTransport alloc] init]; //TODO: Java uses this line. figure out what to do for Objective-C
    }
    return self;
}

- (instancetype)initWithMaxTimeout:(int)maxTimeout {
    if (self = [[super self] init]) {
        _maxTimeout = maxTimeout;
    }
    return self;
}

- (SSResponse*)sendRequest:(SSRequest*)request withError:(NSError**)error {
    return nil; //TODO: implement
}

@end
