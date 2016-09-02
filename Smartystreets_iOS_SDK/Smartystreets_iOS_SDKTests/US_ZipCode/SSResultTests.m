#import <XCTest/XCTest.h>
#import "SSResult.h"

@interface SSResultTests : XCTestCase
@property (nonatomic) SSResult *result;
@end

@implementation SSResultTests

- (void)setUp {
    [super setUp];
    _result = [[SSResult alloc] init];
}

- (void)tearDown {

    [super tearDown];
}

- (void)testIsValidReturnsTrueWhenInputIsValid {
    XCTAssertTrue([self.result isValid]);
}

- (void)testIsValidReturnsFalseWhenInputIsNotValid {
    self.result.status = @"invalid_zipcode";
    self.result.reason = @"invalid_reason";
    
    XCTAssertEqual(false, [self.result isValid]);
}

@end
