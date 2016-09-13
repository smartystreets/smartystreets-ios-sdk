#import <XCTest/XCTest.h>
#import "SSJsonSerializer.h"

//---------------------- Inner Classes -----------------------//
@interface StringProperty : NSObject

@property (nonatomic) NSString *name;

- (instancetype)initWithName:(NSString*)name;

@end

@implementation StringProperty

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init])
        _name = name;
    return self;
}

@end

@interface IntProperty : NSObject

@property (nonatomic) int number;

- (instancetype)initWithNumber:(int)number;

@end

@implementation IntProperty

- (instancetype)initWithNumber:(int)number {
    if (self = [super init])
        _number = number;
    return self;
}

@end

@interface BoolProperty : NSObject

@property (nonatomic) bool booleanValue;

- (instancetype)initWithBooleanValue:(int)booleanValue;

@end

@implementation BoolProperty

- (instancetype)initWithBooleanValue:(int)booleanValue {
    if (self = [super init])
        _booleanValue = booleanValue;
    return self;
}

@end
//------------------------------------------------------------//

@interface SSJsonSerializerTests : XCTestCase

@property (readonly, nonatomic) SSJsonSerializer *serializer;

@end

@implementation SSJsonSerializerTests

- (void)setUp {
    [super setUp];
    _serializer = [[SSJsonSerializer alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSerializationOfNullValues {
    NSMutableData *results = [self.serializer serialize:nil];
    
    XCTAssertNil(results);
}

- (void)testSerializationOfKnownType {
    NSString *jsonString = @"{\"Property2\":42,\"Property3\":true,\"property_1\":\"Name\"}";
    NSData *expectedJson = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    StringProperty *stringProperty = [[StringProperty alloc] initWithName:@"Name"];
//    IntProperty *intProperty = [[IntProperty alloc] initWithNumber:42];
//    BoolProperty *boolProperty = [[BoolProperty alloc] initWithBooleanValue:true];
    
//    NSMutableArray *lookups = [[NSMutableArray alloc] init];
//    [lookups addObject:stringProperty];
//    [lookups addObject:intProperty];
//    [lookups addObject:boolProperty];
//    NSMutableData *lookupBytes = [self.serializer serialize:lookups];
    
    NSMutableDictionary *testLookups = [[NSMutableDictionary alloc] init];
    [testLookups setValue:@"name" forKey:@"Property1"];
    [testLookups setValue:@42 forKey:@"Property2"];
    [testLookups setValue:@YES forKey:@"Property3"];
    NSMutableData *lookupBytes = [self.serializer serialize:testLookups];
    
    XCTAssertEqual(expectedJson, lookupBytes);
}

- (void)testDeserializationOfNullStream {
    
}

- (void)TestDeserializationOfKnownType {
    
}

@end

//[DataContract]
//public class StandardLibraryJsonSerializerTestObject
//{
//    [DataMember(Name = "property_1")]
//    public string Property1 { get; set; }
//    
//    [DataMember(Name = "Property2")]
//    public int Property2 { get; set; }
//    
//    [DataMember(Name = "Property3")]
//    public bool Property3 { get; set; }
//}
