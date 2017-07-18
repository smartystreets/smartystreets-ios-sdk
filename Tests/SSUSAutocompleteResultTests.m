#import <XCTest/XCTest.h>
#import "SSUSAutocompleteResult.h"
#import "SSUSAutocompleteSuggestion.h"

@interface SSUSAutocompleteResultTests : XCTestCase {
    NSDictionary *obj;
}

@end

@implementation SSUSAutocompleteResultTests

- (void)setUp {
    [super setUp];
    obj = @{
            @"suggestions": [NSArray arrayWithObjects:
                             @{
                               @"text": @"1",
                               @"street_line": @"2",
                               @"city": @"3",
                               @"state": @"4"
                               }, nil]
            };
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAllFieldsGetFilledInCorrectly {
    SSUSAutocompleteResult *result = [[SSUSAutocompleteResult alloc] initWithDictionary:obj];
    
    SSUSAutocompleteSuggestion *suggestion = [result getSuggestionAtIndex:0];
    
    XCTAssertEqual(@"1", suggestion.text);
    XCTAssertEqual(@"2", suggestion.streetLine);
    XCTAssertEqual(@"3", suggestion.city);
    XCTAssertEqual(@"4", suggestion.state);
}

- (void)testWhenSuggestionsIsNullCreatesNewNSMutableArray {
    NSNull *nullObj = [NSNull null];
    obj = @{
            @"suggestions": nullObj
            };
    
    SSUSAutocompleteResult *result = [[SSUSAutocompleteResult alloc] initWithDictionary:obj];
    XCTAssertNotNil(result.suggestions);
}

@end
