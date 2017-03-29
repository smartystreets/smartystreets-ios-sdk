#import <XCTest/XCTest.h>
#import "SSUSZipCodeResult.h"

@interface SSUSZipCodeResultTests : XCTestCase
@property (nonatomic) SSUSZipCodeResult *result;
@end

@implementation SSUSZipCodeResultTests

- (void)setUp {
    [super setUp];
    _result = [[SSUSZipCodeResult alloc] init];
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
