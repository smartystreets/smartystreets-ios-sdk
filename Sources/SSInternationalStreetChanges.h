#import <Foundation/Foundation.h>
#import "SSInternationalStreetRootLevel.h"
#import "SSInternationalStreetComponents.h"

@interface SSInternationalStreetChanges : SSInternationalStreetRootLevel

@property (readonly, nonatomic) SSInternationalStreetComponents *components;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
