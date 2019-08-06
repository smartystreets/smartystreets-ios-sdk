#import "ObjCZIPExample.h"

@interface ObjCZIPExample ()

@end

@implementation ObjCZIPExample

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"lines-map"] drawInRect:self.view.bounds];
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
    
    _batch = [[USZipCodeBatch alloc] init];
}

- (IBAction)lookup:(UIButton *)sender {
    _results.text = [self run];
    _batch = [[USZipCodeBatch alloc] init];
}

- (IBAction)add:(UIButton *)sender {
    USZipCodeLookup *lookup = [[USZipCodeLookup alloc] initWithCity:_city.text state:_state.text zipcode:_zipCode.text inputId:_inputId.text];
    
    NSError* error = nil;
    
    _Bool success = [_batch addWithNewAddress:lookup error:&error];
    
    if (!success) {
        NSLog(@"Description: %@", [error localizedDescription]);
        _results.text = [error localizedDescription];
        return;
    }
}

- (NSString*)run {
    NSString* authId = @"af79ba24-4971-9d11-ec86-e0c768a7694e";
    NSString* authToken = @"DGQcdrLC2TmOm913YUe7";
    USZipCodeClient *client = [[ClientBuilder alloc] initWithAuthId:authId authToken:authToken].buildUsZIPCodeApiClient;
    NSError* error = nil;
    
    _Bool success = [client sendBatchWithBatch:_batch error:&error];
    
    if (!success) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %i", (int)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    
    NSArray* lookups = _batch.allLookups;
    NSMutableString* output = [[NSMutableString alloc] init];
    
    for (int i = 0; i < _batch.count; i++) {
        USZipCodeLookup* lookup = [lookups objectAtIndex:i];
        USZipCodeResult* result = lookup.result;
        [output appendString:[@"\nLookup " stringByAppendingString:[@(i + 1) stringValue]]];
        [output appendString:[@"\nInput ID: " stringByAppendingString:lookup.inputId]];
        [output appendString:@"\n\n"];
        
        if (result.status != nil) {
            [output appendString:[@"Status: " stringByAppendingString:result.status]];
            [output appendString:[@"\nReason: " stringByAppendingString:result.reason]];
            [output appendString:@"\n"];
            continue;
        }
        
        if (result.cities == nil && result.zipCodes == nil) {
            [output appendString:@"Error getting cities and zip codes.\n\n"];
            [output appendString:@"***************\n\n"];
            continue;
        }
        
        NSArray<USCity*> *cities = result.cities;
        [output appendString:[@(cities.count) stringValue]];
        [output appendString:@" City and States match(es):"];
        
        for (USCity *city in cities) {
            [output appendString:[@"\nCity: " stringByAppendingString:city.city]];
            [output appendString:[@"\nState: " stringByAppendingString:city.state]];
            [output appendString:[@"\nMailable City: " stringByAppendingString:city.objcMailableCity ? @"YES" : @"NO"]];
            [output appendString:@"\n"];
        }
        
        [output appendString:@"\n"];
        NSArray<USZipCode*> *zipCodes = result.zipCodes;
        [output appendString:[@(zipCodes.count) stringValue]];
        [output appendString:@" ZIP Code match(es):"];
        
        for (USZipCode *zip in zipCodes) {
            [output appendString:[@"\nZIP Code: " stringByAppendingString:zip.zipCode]];
            [output appendString:[@"\nCounty: " stringByAppendingString:zip.countyName]];
            [output appendString:[@"\nLatitude: " stringByAppendingString:[zip.objcLatitude stringValue]]];
            [output appendString:[@"\nLongitude: " stringByAppendingString:[zip.objcLongitude stringValue]]];
            [output appendString:@"\n"];
        }
        [output appendString:@"***********************************\n"];
    }
    
    NSLog(@"Output = %@", output);
    return output;
}

- (IBAction)Return:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
