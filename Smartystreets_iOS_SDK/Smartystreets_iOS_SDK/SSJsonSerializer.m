#import "SSJsonSerializer.h"

@implementation SSJsonSerializer

- (NSData*)serialize:(NSObject*)obj error:(NSError**)error {
    if (!obj)
        return nil;
    
    //maybe pass in withClassType to be able to do [classType toDictionary:obj];
    
//    NSDictionary *dictionary = [obj toDictionary]
    
    return [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:error];
    
////    [NSJSONSerialization ]
//    
//    NSMutableDictionary *jsonData = obj;
//
////    NSArray<NSString*>* arr = @[@"str"];
////    
////    NSString* string = [arr objectAtIndex:0];
////    NSNumber* number = [arr objectAtIndex:0];
//
//    NSString *deleteThisString = @"delete";
//    
//    return nil; //TODO: implement
}

- (NSArray*)deserialize:(NSData*)payload withClassType:(Class)classType error:(NSError**)error {
    if (payload == nil)
        return nil;
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:payload options:NSJSONReadingMutableContainers error:error];
    
    NSMutableArray *results = [NSMutableArray new];
    for (int i = 0; i < [json count]; i++) {
        NSObject *result = [[classType alloc] initWithDictionary:[json objectAtIndex:i]];
        [results addObject:result];
    }
    
    return [NSArray arrayWithArray:results];
}

@end
