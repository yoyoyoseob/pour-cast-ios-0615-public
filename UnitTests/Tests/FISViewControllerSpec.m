//
//  FISViewControllerSpec.m
//  pour-cast
//
//  Created by Timothy Clem on 4/23/15.
//  Copyright 2015 The Flatiron School. All rights reserved.
//

#define EXP_SHORTHAND

#import "Specta.h"
#import "Expecta.h"
#import "FISDailyForecastView.h"
#import "FISDailyForecast.h"
#import "FISAppDelegate.h"
#import "ForcastAPIClient.h"
#import <KIF/KIF.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OCMockito/OCMockito.h>


SpecBegin(FISViewController)

describe(@"FISViewController", ^{
    __block NSDictionary *fakeJSON = nil;
    __block NSData *fakeJSONData = nil;
    __block NSArray *fakeDeserializedModels = nil;

    __block UIWindow *mainWindow = nil;
    __block UIViewController *oldRootVC = nil;

    beforeAll(^{
        fakeJSON = @{ @"daily": @{
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

        fakeJSONData = [NSJSONSerialization dataWithJSONObject:fakeJSON options:0 error:NULL];

        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
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
        mainWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    });
    
    beforeEach(^{

    });
    
    it(@"should assign the proper models to the 5 day views", ^{
        [tester waitForTimeInterval:1];  // Need to wait for the API call in the VC to complete

        for(NSUInteger i = 1; i <= 5; i++) {
            NSString *label = [NSString stringWithFormat:@"forecastView%lu", (unsigned long)i];
            FISDailyForecastView *view = (FISDailyForecastView *)[tester waitForViewWithAccessibilityLabel:label];

            FISDailyForecast *expectedModel = fakeDeserializedModels[i];
            expect(view.dailyForecast.date).to.equal(expectedModel.date);
            expect(view.dailyForecast.temperatureMin).to.equal(expectedModel.temperatureMin);
            expect(view.dailyForecast.temperatureMax).to.equal(expectedModel.temperatureMax);
        }
    });
    
    afterEach(^{

    });
    
    afterAll(^{
        [OHHTTPStubs removeLastStub];
        mainWindow.rootViewController = oldRootVC;
    });
});

SpecEnd
