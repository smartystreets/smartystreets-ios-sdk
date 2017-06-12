#import <Foundation/Foundation.h>
#import "ApiIntegrationTests.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ApiIntegrationTests *test = [[ApiIntegrationTests alloc] init];
        [test runAllApiIntegrationTests];
    }
    return 0;
}
