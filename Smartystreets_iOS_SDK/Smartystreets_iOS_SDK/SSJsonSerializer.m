#import "SSJsonSerializer.h"

@implementation SSJsonSerializer

- (NSMutableData*)serialize:(NSObject*)obj {
    if (!obj)
        return nil;
    
    NSMutableDictionary *jsonData = obj;

//    NSArray<NSString*>* arr = @[@"str"];
//    
//    NSString* string = [arr objectAtIndex:0];
//    NSNumber* number = [arr objectAtIndex:0];

    NSString *deleteThisString = @"delete";
    
    return nil; //TODO: implement
}

- (NSArray*)deserialize:(NSMutableData *)payload withClassType:(Class)type error:(NSError**)error {
    NSArray *json = [NSJSONSerialization JSONObjectWithData:payload options:NSJSONReadingMutableContainers error:error];
    
    NSMutableArray *results = [NSMutableArray new];
    for (int i = 0; i < [json count]; i++) {
        NSObject *result = [[type alloc] initWithData:[json objectAtIndex:i]];
        [results addObject:result];
    }
    
    return [NSArray arrayWithArray:results];
}

@end
