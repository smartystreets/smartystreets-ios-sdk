#import <Foundation/Foundation.h>

/*!
 @class SSUSStreetAnalysis
 
 @brief The US Street Analysis class
 
 @see https://smartystreets.com/docs/cloud/us-street-api#analysis
 */
@interface SSUSStreetAnalysis : NSObject

@property (readonly, nonatomic) NSString *dpvMatchCode;
@property (readonly, nonatomic) NSString *dpvFootnotes;
@property (readonly, nonatomic) NSString *cmra;
@property (readonly, nonatomic) NSString *vacant;
@property (readonly, nonatomic) NSString *active;
@property (readonly, nonatomic) bool isEwsMatch __attribute__((deprecated));
@property (readonly, nonatomic) NSString *footnotes;
@property (readonly, nonatomic) NSString *lacsLinkCode;
@property (readonly, nonatomic) NSString *lacsLinkIndicator;
@property (readonly, nonatomic) bool isSuiteLinkMatch;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
