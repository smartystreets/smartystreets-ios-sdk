#import <XCTest/XCTest.h>
#import "SSRequest.h"

@interface SSRequestTests : XCTestCase

@end

@implementation SSRequestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testNullNameQueryStringParameterNotAdded {
    [self assertQueryStringParametersField:nil withValue:@"value" withExpectedValue:@"http://localhost/?"];
}

- (void)testEmptyNameQueryStringParameterNotAdded {
    [self assertQueryStringParametersField:@"" withValue:@"value" withExpectedValue:@"http://localhost/?"];
}

- (void)testNullValueQueryStringParameterNotAdded {
    [self assertQueryStringParametersField:@"name" withValue:nil withExpectedValue:@"http://localhost/?"];
}

- (void)testEmptyValueQueryStringParameterIsAdded {
    [self assertQueryStringParametersField:@"name" withValue:@"" withExpectedValue:@"http://localhost/?name="];
}

-(void)assertQueryStringParametersField:(NSString*)name withValue:(NSString*)value withExpectedValue:(NSString*)expectedValue {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/?"];
    
    [request setValue:value forHTTPParameterField:name];
    
    XCTAssertEqualObjects(expectedValue, [request getUrl]);
}

- (void)testMultipleQueryStringParametersAreAdded {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/?"];
    
    [request setValue:@"value1" forHTTPParameterField:@"name1"];
    [request setValue:@"value2" forHTTPParameterField:@"name2"];
    [request setValue:@"value3" forHTTPParameterField:@"name3"];
    
    NSString *const expectedValue = @"http://localhost/?name1=value1&name2=value2&name3=value3";
    XCTAssertEqualObjects(expectedValue, [request getUrl]);
}

- (void)assertUrlEncodingOfQueryStringParameters {
    
}

- (void)testUrlWithoutTrailingQuestionMark {
    
}

- (void)testHeadersAddedToRequest {
    
}

- (void)testGet {
    
}

- (void)testPost {
    
}

@end
