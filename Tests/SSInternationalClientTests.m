#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSURLPrefixSender.h"
#import "SSMockSerializer.h"
#import "SSInternationalStreetClient.h"
#import "SSInternationalStreetLookup.h"


@interface SSInternationalClientTests : XCTestCase

@end

@implementation SSInternationalClientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSendingFreeformLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSInternationalStreetClient *client = [[SSInternationalStreetClient alloc] initWithSender:sender withSerializer:serializer];
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] initWithFreeform:@"freeform" withCountry:@"USA"];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqualObjects(@"http://localhost/?country=USA&freeform=freeform", [capturingSender.request getUrl]);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSInternationalStreetClient *client = [[SSInternationalStreetClient alloc] initWithSender:sender withSerializer:serializer];
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] initWithFreeform:@"freeform" withCountry:@"USA"];
    NSString *expectedUrl = @"http://localhost/?administrative_area=8&address1=2&geocode=true&address2=3&freeform=1&address3=4&address4=5&language=native&postal_code=9&country=0&locality=7&organization=6";
    NSError *error = nil;
    
    lookup.country = @"0";
    lookup.geocode = YES;
    lookup.language = [[SSLanguageMode alloc] initWithName:kSSNative];
    lookup.freeform = @"1";
    lookup.address1 = @"2";
    lookup.address2 = @"3";
    lookup.address3 = @"4";
    lookup.address4 = @"5";
    lookup.organization = @"6";
    lookup.locality = @"7";
    lookup.administrativeArea = @"8";
    lookup.postalCode = @"9";
    
    [client sendLookup:lookup error:&error];
    
    NSString *actualResult = [capturingSender.request getUrl];
    
    XCTAssertEqualObjects(expectedUrl, [capturingSender.request getUrl]);
}

- (void)testEmptyLookupRejected {
    //TODO: finish these tests
}

@end
