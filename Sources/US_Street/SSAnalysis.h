#import <Foundation/Foundation.h>

@interface SSAnalysis : NSObject

@property (readonly, nonatomic) NSString *dpvMatchCode;
@property (readonly, nonatomic) NSString *dpvFootnotes;
@property (readonly, nonatomic) NSString *cmra;
@property (readonly, nonatomic) NSString *vacant;
@property (readonly, nonatomic) NSString *active;
@property (readonly, nonatomic) bool isEwsMatch;
@property (readonly, nonatomic) NSString *footnotes;
@property (readonly, nonatomic) NSString *lacsLinkCode;
@property (readonly, nonatomic) NSString *lacsLinkIndicator;
@property (readonly, nonatomic) bool isSuiteLinkMatch;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
