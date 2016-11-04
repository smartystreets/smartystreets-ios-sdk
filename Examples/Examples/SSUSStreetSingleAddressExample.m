//#import "SSUSStreetSingleAddressExample.h"
//#import </Users/oshion/src/github.com/smartystreets/smartystreets-ios-sdk/Smartystreets_iOS_SDK/Smartystreets_iOS_SDK/US_Street/SSStreetClientBuilder.h> //TODO: get imports working correctly
////#import </Users/oshion/Library/Developer/Xcode/DerivedData/Smartystreets_iOS_SDK-hgqhnhhppaibdnfgaptgxhhngupi/Build/Products/Debug-iphonesimulator/Smartystreets_iOS_SDK.framework/Headers/SSSharedCredentials.h>
//#import "SSMyCredentials.h"
//
//@implementation SSUSStreetSingleAddressExample
//
//- (NSString*)runCode {
////    id<SSCredentials> mobile = [[SSSharedCredentials alloc] initWithId:kSSSmartyWebsiteKey hostname:kSSHost];
////    SSStreetClient *client = [[SSStreetClientBuilder alloc] initWithSigner:mobile].build;
//    SSStreetClient *client = [[SSStreetClientBuilder alloc] initWithAuthId:kSSAuthId authToken:kSSAuthToken].build;
//    
//    SSStreetLookup *lookup = [[SSStreetLookup alloc] init];
//    lookup.street = @"1600 Amphitheatre Pkwy";
//    lookup.city = @"Mountain View";
//    lookup.state = @"CA";
//    
//    NSError *error = nil;
//    [client sendLookup:lookup error:&error];
//    
//    if (error != nil) {
//        //TODO: handle error
//    }
//    
//    NSArray<SSCandidate*> *results = lookup.result;
//    NSMutableString *output = [[NSMutableString alloc] init];
//    
//    if (results.count == 0) {
//        [output appendString:@"Error. Address is not valid"];
//        return output;
//    }
//    
//    SSCandidate *candidate = [results objectAtIndex:0];
//    
//    [output appendString:@"Address is valid. (There is at least one candidate)\n\n"];
//    [output appendString:[@"\nZIP Code: " stringByAppendingString:candidate.components.zipCode]];
//    [output appendString:[@"\nCounty: " stringByAppendingString:candidate.metadata.countyName]];
//    NSNumber *latitude = [NSNumber numberWithDouble:candidate.metadata.latitude];
//    NSNumber *longitute = [NSNumber numberWithDouble:candidate.metadata.longitude];
//    [output appendString:[@"\nLatitude: " stringByAppendingString:[latitude stringValue]]];
//    [output appendString:[@"\nLongitude: " stringByAppendingString:[longitute stringValue]]];
//    
//    return output;
//}
//
//@end
