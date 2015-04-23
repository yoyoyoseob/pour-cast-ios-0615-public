//
//  FISDailyForecastViewSpec.m
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
#import <KIF/KIF.h>

SpecBegin(FISDailyForecastView)

describe(@"FISDailyForecastView", ^{
    __block FISDailyForecast *model = nil;
    __block FISDailyForecastView *view = nil;

    __block UIWindow *mainWindow = nil;
    __block UIViewController *oldRootVC = nil;

    beforeAll(^{
        model = [FISDailyForecast new];
        model.date = [NSDate date];
        model.temperatureMax = 100;
        model.temperatureMin = 50;

        mainWindow = ((FISAppDelegate *)[UIApplication sharedApplication].delegate).window;
        oldRootVC = mainWindow.rootViewController;
        mainWindow.rootViewController = [UIViewController new];  // Blow away any existing VC so its contents don't confuse KIF
    });
    
    beforeEach(^{
        view = [[FISDailyForecastView alloc] initWithFrame:CGRectMake(0, 0, 100, 400)];
        view.dailyForecast = model;

        [mainWindow addSubview:view];
    });
    
    it(@"should display the formatted date of the model", ^{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd"];

        NSString *expectedString = [dateFormatter stringFromDate:model.date];

        UILabel *dayLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"dayLabel"];
        expect(dayLabel.text).to.equal(expectedString);
    });

    it(@"should display the formatted high temperature from the model", ^{
        NSString *expectedString = [NSString stringWithFormat:@"High: %.1fF", model.temperatureMax];

        UILabel *highLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"highLabel"];
        expect(highLabel.text).to.equal(expectedString);
    });

    it(@"should display the formatted low temperature from the model", ^{
        NSString *expectedString = [NSString stringWithFormat:@"Low: %.1fF", model.temperatureMin];

        UILabel *lowLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"lowLabel"];
        expect(lowLabel.text).to.equal(expectedString);
    });
    
    afterEach(^{
        [view removeFromSuperview];
    });
    
    afterAll(^{
        mainWindow.rootViewController = oldRootVC;
    });
});

SpecEnd
