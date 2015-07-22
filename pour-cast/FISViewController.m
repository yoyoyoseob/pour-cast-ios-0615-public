//
//  FISViewController.m
//  pour-cast
//
//  Created by Joe Burgess on 11/19/14.
//  Copyright (c) 2014 The Flatiron School. All rights reserved.
//

#import "FISViewController.h"
#import "ForcastAPIClient.h"
#import "FISDailyForecast.h"
#import "FISDailyForecastView.h"

@interface FISViewController ()

@property (weak, nonatomic) IBOutlet FISDailyForecastView *day1View;
@property (weak, nonatomic) IBOutlet FISDailyForecastView *day2View;
@property (weak, nonatomic) IBOutlet FISDailyForecastView *day3View;
@property (weak, nonatomic) IBOutlet FISDailyForecastView *day4View;
@property (weak, nonatomic) IBOutlet FISDailyForecastView *day5View;

@end

@implementation FISViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [ForcastAPIClient getForecastForCoordinate:CLLocationCoordinate2DMake(37.8267, -122.423) Completion:^(NSArray *dailyForecastModels) {
        
        NSArray *dayViews = @[ self.day1View, self.day2View, self.day3View, self.day4View, self.day5View];
        
        for (NSUInteger i = 0; i < dayViews.count; i ++)
        {
            FISDailyForecast *day = dailyForecastModels[i + 1];
            FISDailyForecastView *forecast = dayViews[i];
            forecast.dailyForecast = day;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
