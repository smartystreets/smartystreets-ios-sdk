#import "SSStreetClient.h"

@interface SSStreetClient()

@property (readonly, nonatomic) NSString *urlPrefix;
@property (readonly, nonatomic) id<SSSender> sender;
@property (readonly, nonatomic) id<SSSerializer> serializer;

@end

@implementation SSStreetClient

- (instancetype)initWithUrlPrefix:(NSString*)urlPrefix withSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer {
    if (self = [super init]) {
        _urlPrefix = urlPrefix;
        _sender = sender;
        _serializer = serializer;
    }
    return self;
}

- (void)sendLookup:(SSStreetLookup*)lookup error:(NSError**)error {
    
}

- (void)sendBatch:(SSStreetBatch*)batch error:(NSError**)error {
    
}

- (void)setHeaders:(SSStreetBatch*)batch request:(SSRequest*)request {
    
}

- (void)populateQueryString:(SSStreetLookup*)lookup withRequest:(SSRequest*)request {
    
}

- (void)assignCandidatesToLookups:(SSStreetBatch*)batch candidates:(NSArray*)candidates {
    
}

@end
