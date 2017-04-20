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

- (id)deserialize:(NSData*)payload error:(NSError**)error {
    if (payload == nil) {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"The payload is nil."};
        *error = [NSError errorWithDomain:SSErrorDomain code:ObjectNilError userInfo:details];
        return nil;
    }
    
    return [NSJSONSerialization JSONObjectWithData:payload options:NSJSONReadingMutableContainers error:error];
}

@end
