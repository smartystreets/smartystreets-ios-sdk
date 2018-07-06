#import "ApiIntegrationTests.h"

@interface ApiIntegrationTests()

@property (nonatomic) NSMutableString *result;

@end

@implementation ApiIntegrationTests

- (instancetype)init {
    if (self = [super init]) {
        _result = [NSMutableString new];
    }
    return self;
}

- (void)runAllApiIntegrationTests {
    NSString *authID = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_ID"];
    NSString *authToken = [[[NSProcessInfo processInfo] environment] objectForKey:@"SMARTY_AUTH_TOKEN"];
    SSStaticCredentials *credentials = [[SSStaticCredentials alloc] initWithAuthId:authID authToken:authToken];
    
    [self testInternationalStreetRequestReturnsWithCorrectNumberOfResults:credentials];
    [self testUSAutocompleteRequestReturnsWithCorrectNumberOfResults:credentials];
    [self testUSExtractRequestReturnsWithCorrectNumberOfResults:credentials];
    [self testUSStreetRequestReturnsWithCorrectNumberOfResults:credentials];
    [self testUSZIPCodeRequestReturnsWithCorrectNumberOfResults:credentials];
    [self testReturnsCorrectNumberOfResultsViaProxy:credentials];
    
    NSLog(@"%@", self.result);
}

- (void)testInternationalStreetRequestReturnsWithCorrectNumberOfResults:(SSStaticCredentials*)credentials {
    SSInternationalStreetClient *client = [[[[SSClientBuilder alloc] initWithSigner:credentials] retryAtMost:2] buildInternationalStreetApiClient];
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] initWithFreeform:@"Rua Padre Antonio D'Angelo 121 Casa Verde, Sao Paulo" withCountry:@"Brazil"];
    
    NSError *error = nil;
    [client sendLookup:lookup error:&error];
    
    int candidates = 0;
    if (error == nil)
        candidates = (int)lookup.result.count;
    
    [self assertResults:@"International_Street" actualResultCount:candidates expectedResultCount:1];
}

- (void)testUSAutocompleteRequestReturnsWithCorrectNumberOfResults:(SSStaticCredentials*)credentials {
    SSUSAutocompleteClient *client = [[[[SSClientBuilder alloc] initWithSigner:credentials] retryAtMost:2] buildUsAutocompleteApiClient];
    SSUSAutocompleteLookup *lookup = [[SSUSAutocompleteLookup alloc] initWithPrefix:@"4770 Lincoln Ave O"];
    [lookup addStateFilter:@"IL"];
    
    NSError *error = nil;
    [client sendLookup:lookup error:&error];
    
    int suggestions = 0;
    if (error == nil)
        suggestions = (int)lookup.result.count;
    
    [self assertResults:@"US_Autocomplete" actualResultCount:suggestions expectedResultCount:9];
}

- (void)testUSExtractRequestReturnsWithCorrectNumberOfResults:(SSStaticCredentials*)credentials {
    SSUSExtractClient *client = [[[[SSClientBuilder alloc] initWithSigner:credentials] retryAtMost:2] buildUsExtractApiClient];
    NSString *text = @"Here is some text.\r\nMy address is 3785 Las Vegs Av.\r\nLos Vegas, Nevada.\r\nMeet me at 1 Rosedale Baltimore Maryland, not at 123 Phony Street, Boise Idaho.";
    SSUSExtractLookup *lookup = [[SSUSExtractLookup alloc] initWithText:text];
    
    NSError *error = nil;
    [client sendLookup:lookup error:&error];
    
    int addresses = 0;
    if (error == nil)
        addresses = (int)lookup.result.addresses.count;
    
    [self assertResults:@"US_Extract" actualResultCount:addresses expectedResultCount:3];
}

- (void)testUSStreetRequestReturnsWithCorrectNumberOfResults:(SSStaticCredentials*)credentials {
    SSUSStreetClient *client = [[[[SSClientBuilder alloc] initWithSigner:credentials] retryAtMost:2] buildUsStreetApiClient];
    SSUSStreetLookup *lookup = [[SSUSStreetLookup alloc] initWithFreeformAddress:@"1 Rosedale, Baltimore, Maryland"];
    NSError *error = nil;
    [lookup setMaxCandidates:10 error:&error];
    
    [client sendLookup:lookup error:&error];
    
    int candidates = 0;
    if (error == nil)
        candidates = (int)lookup.result.count;
    
    [self assertResults:@"US_Street" actualResultCount:candidates expectedResultCount:2];
}

- (void)testUSZIPCodeRequestReturnsWithCorrectNumberOfResults:(SSStaticCredentials*)credentials {
    SSUSZipCodeClient *client = [[[[SSClientBuilder alloc] initWithSigner:credentials] retryAtMost:2] buildUsZIPCodeApiClient];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] initWithZipcode:@"38852"];
    
    NSError *error =nil;
    [client sendLookup:lookup error:&error];
    
    int citiesAmount = 0;
    if (error == nil)
        citiesAmount = (int)lookup.result.cities.count;
    
    [self assertResults:@"US_ZIPCode" actualResultCount:citiesAmount expectedResultCount:7];
}

- (void)testReturnsCorrectNumberOfResultsViaProxy:(SSStaticCredentials*)credentials {
    NSError *error = nil;
    SSUSZipCodeClient *client = [[[[[SSClientBuilder alloc] initWithSigner:credentials] retryAtMost:2] withProxy:@"proxy.api.smartystreets.com" port:80] buildUsZIPCodeApiClient];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] initWithZipcode:@"38852"];
    
    [client sendLookup:lookup error:&error];
    
    int citiesAmount = 0;
    if (error == nil)
        citiesAmount = (int)lookup.result.cities.count;
    
    [self assertResults:@"US_ZIPCode-proxy" actualResultCount:citiesAmount expectedResultCount:7];
}

- (void)assertResults:(NSString*)apiType actualResultCount:(int)actual expectedResultCount:(int)expected {
    [self.result appendString:@"\n"];
    [self.result appendString:apiType];
    
    if (actual == expected)
        [self.result appendString:@" - OK"];
    else {
        [self.result appendFormat:@" - FAILED (Expected: %i", expected];
        [self.result appendFormat:@", Actual: %i", actual];
        [self.result appendString:@")"];
    }
}

@end
