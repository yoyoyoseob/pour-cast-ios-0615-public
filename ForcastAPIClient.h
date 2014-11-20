//
//  ForcastAPIClient.h
//  
//
//  Created by Joe Burgess on 11/20/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface ForcastAPIClient : NSObject

+ (void) getForecastForCoordinate:(CLLocationCoordinate2D)location Completion:(void (^)(NSArray *dailyForecast))completion;
@end
