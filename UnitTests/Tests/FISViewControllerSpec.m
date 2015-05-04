//
//  FISViewControllerSpec.m
//  pour-cast
//
//  Created by Timothy Clem on 4/23/15.
//  Copyright 2015 The Flatiron School. All rights reserved.
//

#define EXP_SHORTHAND
#define MOCKITO_SHORTHAND
#define HC_SHORTHAND

#import "Specta.h"
#import "Expecta.h"
#import "FISDailyForecastView.h"
#import "FISDailyForecast.h"
#import "FISAppDelegate.h"
#import "ForcastAPIClient.h"
#import <KIF/KIF.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>


SpecBegin(FISViewController)

describe(@"FISViewController", ^{
    __block NSArray *fakeDeserializedModels = nil;

    __block UIWindow *mainWindow = nil;
    __block UIViewController *oldRootVC = nil;

    __block id<OHHTTPStubsDescriptor> httpStub;


    beforeAll(^{
        NSDictionary *fakeJSON = @{ @"daily": @{
                                        @"data": @[
                                            @{ @"time": @100,
                                               @"temperatureMin": @10,
                                               @"temperatureMax": @100
                                               },
                                            @{ @"time": @200,
                                               @"temperatureMin": @20,
                                               @"temperatureMax": @200
                                               },
                                            @{ @"time": @300,
                                               @"temperatureMin": @30,
                                               @"temperatureMax": @300
                                               },
                                            @{ @"time": @400,
                                               @"temperatureMin": @40,
                                               @"temperatureMax": @400
                                               },
                                            @{ @"time": @500,
                                               @"temperatureMin": @50,
                                               @"temperatureMax": @500
                                               },
                                            @{ @"time": @600,
                                               @"temperatureMin": @60,
                                               @"temperatureMax": @600
                                               }
                                            ]
                                        }
                                    };

        NSData *fakeJSONData = [NSJSONSerialization dataWithJSONObject:fakeJSON options:0 error:NULL];

        httpStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.host isEqualToString:@"api.forecast.io"];
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            return [OHHTTPStubsResponse responseWithData:fakeJSONData
                                              statusCode:200
                                                 headers:@{ @"Content-type": @"application/json" }];
        }];

        waitUntil(^(DoneCallback done) {
            [ForcastAPIClient getForecastForCoordinate:CLLocationCoordinate2DMake(10, 10) Completion:^(NSArray *dailyForecastModels) {
                fakeDeserializedModels = dailyForecastModels;
                done();
            }];
        });

        mainWindow = ((FISAppDelegate *)[UIApplication sharedApplication].delegate).window;
        oldRootVC = mainWindow.rootViewController;

        UIViewController *forecastViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        mainWindow.rootViewController = forecastViewController;
    });
    
    it(@"should assign the proper models to the 5 day views", ^{
        for(NSUInteger i = 1; i <= 5; i++) {
            NSString *label = [NSString stringWithFormat:@"forecastView%lu", (unsigned long)i];
            FISDailyForecastView *view = (FISDailyForecastView *)[tester waitForViewWithAccessibilityLabel:label];
            FISDailyForecast *expectedModel = fakeDeserializedModels[i];

            expect(view.dailyForecast).will.equal(expectedModel);
        }
    });
    
    afterAll(^{
        [OHHTTPStubs removeStub:httpStub];
        mainWindow.rootViewController = oldRootVC;
    });
});

SpecEnd
