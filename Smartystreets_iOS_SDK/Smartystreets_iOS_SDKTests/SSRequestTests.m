//
//  SSRequestTests.m
//  Smartystreets_iOS_SDK
//
//  Created by Oshion Niemela on 8/3/16.
//  Copyright © 2016 SmartyStreets. All rights reserved.
//

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
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/?"];
    
    [request setValue:@"value" forHTTPParameterField:nil];
    
    XCTAssertEqualObjects(@"http://localhost/?", [request getUrl]);
}

- (void)testEmptyValueQueryStringParameterIsAdded {
    [self assertQueryStringParameters:<#(NSString *)#> withValue:<#(NSString *)#> withExpectedValue:<#(NSString *)#>]
}

-(void)assertQueryStringParameters:(NSString*)name withValue:(NSString*)value withExpectedValue:(NSString*)expectedValue {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/?"];
    
    [request setValue:@"" forHTTPParameterField:@"name"];
    
    XCTAssertEqualObjects(@"http://localhost/?name=", [request getUrl]);
}

@end
