//
//  ForcastAPIClient.m
//  
//
//  Created by Joe Burgess on 11/20/14.
//
//

#import "ForcastAPIClient.h"
#import <AFNetworking.h>
#import <CoreLocation/CoreLocation.h>
@implementation ForcastAPIClient
+ (void)getForecastForCoordinate:(CLLocationCoordinate2D)location Completion:(void (^)(NSArray *))completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"https://api.forecast.io/forecast/12f5147f5379a5fab6339c5d97f21b6b/%f,%f",location.latitude, location.longitude];

    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject[@"daily"][@"data"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"ERROR: %@",error.localizedDescription);
    }];
}
@end
