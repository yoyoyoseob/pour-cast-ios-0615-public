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
#import "FISDailyForecast.h"

@implementation ForcastAPIClient
+ (void)getForecastForCoordinate:(CLLocationCoordinate2D)location Completion:(void (^)(NSArray *))completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"https://api.forecast.io/forecast/12f5147f5379a5fab6339c5d97f21b6b/%f,%f",location.latitude, location.longitude];

    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dayDictionaries = responseObject[@"daily"][@"data"];
        NSMutableArray *models = [NSMutableArray array];
        for(NSDictionary *dayDictionary in dayDictionaries) {
            FISDailyForecast *model = [[FISDailyForecast alloc] initWithDictionary:dayDictionary];
            [models addObject:model];
        }

        completion(models);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"ERROR: %@",error.localizedDescription);
    }];
}
@end
