#import "SSJsonSerializer.h"
#import "SSLookup.h"

@implementation SSJsonSerializer

- (NSData*)serialize:(id)obj withClassType:(Class)classType error:(NSError**)error {
    if (!obj) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"The object to be serialized is nil."};
        *error = [NSError errorWithDomain:SSErrorDomain code:ObjectNilError userInfo:details];
        return nil;
    }
    
    if (![obj isKindOfClass:[NSArray class]]) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"The object to be serialized is not the correct type."};
        *error = [NSError errorWithDomain:SSErrorDomain code:ObjectInvalidTypeError userInfo:details];
        return nil;
    }
    
    NSMutableArray<SSLookup> *lookups = obj;
    NSMutableArray *arrayOfLookupDictionaries = [NSMutableArray new];
    
    for (id<SSLookup> lookup in lookups) {
        [arrayOfLookupDictionaries addObject:[lookup toDictionary]];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:arrayOfLookupDictionaries options:kNilOptions error:error];
    return data;
}

- (NSArray*)deserialize:(NSData*)payload withClassType:(Class)classType error:(NSError**)error {
    if (payload == nil) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"The payload is nil."};
        *error = [NSError errorWithDomain:SSErrorDomain code:ObjectNilError userInfo:details];
        return nil;
    }
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:payload options:NSJSONReadingMutableContainers error:error];
    
    NSMutableArray *results = [NSMutableArray new];
    for (int i = 0; i < [json count]; i++) {
        NSObject *result = [[classType alloc] initWithDictionary:[json objectAtIndex:i]];
        [results addObject:result];
    }
    
    return [NSArray arrayWithArray:results];
}

@end
