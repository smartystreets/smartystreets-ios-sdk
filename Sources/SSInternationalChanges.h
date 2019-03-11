#import <Foundation/Foundation.h>
#import "SSInternationalStreetComponents.h"

@interface SSInternationalStreetChanges : NSObject

@property (readonly, nonatomic) NSString *organization;
@property (readonly, nonatomic) NSString *address1;
@property (readonly, nonatomic) NSString *address2;
@property (readonly, nonatomic) NSString *address3;
@property (readonly, nonatomic) NSString *address4;
@property (readonly, nonatomic) NSString *address5;
@property (readonly, nonatomic) NSString *address6;
@property (readonly, nonatomic) NSString *address7;
@property (readonly, nonatomic) NSString *address8;
@property (readonly, nonatomic) NSString *address9;
@property (readonly, nonatomic) NSString *address10;
@property (readonly, nonatomic) NSString *address11;
@property (readonly, nonatomic) NSString *address12;
@property (readonly, nonatomic) SSInternationalStreetComponents *components;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end
