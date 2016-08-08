#import <XCTest/XCTest.h>
#import "SSRequest.h"

@interface SSRequestTests : XCTestCase

@end

@implementation SSRequestTests

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

- (void)testUrlEncodingOfQueryStringParameters {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/"];
    
    [request setValue:@"value" forHTTPParameterField:@"name&"];
    [request setValue:@"other !value$" forHTTPParameterField:@"name2"];
    
    NSString *const expectedValue = @"http://localhost/?name%26=value&name2=other+!value%24";
    
    XCTAssertEqualObjects(expectedValue, [request getUrl]);
}

- (void)testUrlWithoutTrailingQuestionMark {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/"];
    
    NSString *const expectedValue = @"http://localhost/?";
    XCTAssertEqualObjects(expectedValue, [request getUrl]);
}

- (void)testHeadersAddedToRequest {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/"];
    
    [request setValue:@"value1" forHTTPHeaderField:@"header1"];
    [request setValue:@"value2" forHTTPHeaderField:@"header2"];
    
    XCTAssertEqualObjects(@"value1", request.headers[@"header1"]);
    XCTAssertEqualObjects(@"value2", request.headers[@"header2"]);
}

- (void)testGet {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/"];
    
    XCTAssertEqualObjects(@"GET", request.method);
    XCTAssertNil(request.payload);
}

- (void)testPost {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSArray *array = @[@0, @1, @2];
    for (NSInteger i = 0; i < array.count; i++) {
        NSInteger currentNumber = (int)[array objectAtIndex:i];
        [data appendBytes:&currentNumber length:sizeof(currentNumber)];
    }
    
    [request setPayload:data];
    NSMutableData *actualPayload = request.payload;
    
    XCTAssertEqualObjects(@"POST", request.method);
    XCTAssertEqualObjects(data, actualPayload);
}

@end
