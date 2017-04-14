#import <Foundation/Foundation.h>

extern NSString *const kSSGeolocateTypeCity;
extern NSString *const kSSGeolocateTypeState;
extern NSString *const kSSGeolocateTypeNone;

@interface SSGeolocateType : NSObject

@property(readonly, nonatomic) NSString *name;

- (instancetype)initWithName:(NSString*)name;

@end
