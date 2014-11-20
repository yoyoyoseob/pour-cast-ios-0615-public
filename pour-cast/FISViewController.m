//
//  FISViewController.m
//  pour-cast
//
//  Created by Joe Burgess on 11/19/14.
//  Copyright (c) 2014 The Flatiron School. All rights reserved.
//

#import "FISViewController.h"
#import "ForcastAPIClient.h"

@interface FISViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dayOneName;
@property (weak, nonatomic) IBOutlet UILabel *dayOneHighTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayOneLowTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayTwoName;
@property (weak, nonatomic) IBOutlet UILabel *dayTwoHighTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayTwoLowTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayThreeName;
@property (weak, nonatomic) IBOutlet UILabel *dayThreeHighTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayThreeLowTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayFourName;
@property (weak, nonatomic) IBOutlet UILabel *dayFourHighTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayFourLowTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayFiveName;
@property (weak, nonatomic) IBOutlet UILabel *dayFiveHighTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayFiveLowTemp;

@end

@implementation FISViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [ForcastAPIClient getForecastForCoordinate:CLLocationCoordinate2DMake(37.8267, -122.423) Completion:^(NSArray *dailyForecast) {

        NSDictionary *dayOne = dailyForecast[1];
        NSInteger time = [dayOne[@"time"] integerValue];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];

        [format setDateFormat:@"MM/dd"];
        NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970:time];
        NSString *maxTemp = [NSString stringWithFormat:@"High: %@F",dayOne[@"temperatureMax"]];
        NSString *minTemp = [NSString stringWithFormat:@"Low: %@F",dayOne[@"temperatureMin"]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.dayOneHighTemp.text = maxTemp;
            self.dayOneLowTemp.text = minTemp;
            self.dayOneName.text = [format stringFromDate:dateTime];
        }];

        NSDictionary *day = dailyForecast[2];
        time = [day[@"time"] integerValue];
        dateTime = [NSDate dateWithTimeIntervalSince1970:time];
        maxTemp = [NSString stringWithFormat:@"High: %@F",day[@"temperatureMax"]];
        minTemp = [NSString stringWithFormat:@"Low: %@F",day[@"temperatureMin"]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.dayTwoHighTemp.text = maxTemp;
            self.dayTwoLowTemp.text = minTemp;
            self.dayTwoName.text = [format stringFromDate:dateTime];
        }];
        day = dailyForecast[3];
        time = [day[@"time"] integerValue];
        dateTime = [NSDate dateWithTimeIntervalSince1970:time];
        maxTemp = [NSString stringWithFormat:@"High: %@F",day[@"temperatureMax"]];
        minTemp = [NSString stringWithFormat:@"Low: %@F",day[@"temperatureMin"]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.dayThreeHighTemp.text = maxTemp;
            self.dayThreeLowTemp.text = minTemp;
            self.dayThreeName.text = [format stringFromDate:dateTime];
        }];
        day = dailyForecast[4];
        time = [day[@"time"] integerValue];
        dateTime = [NSDate dateWithTimeIntervalSince1970:time];
        maxTemp = [NSString stringWithFormat:@"High: %@F",day[@"temperatureMax"]];
        minTemp = [NSString stringWithFormat:@"Low: %@F",day[@"temperatureMin"]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.dayFourHighTemp.text = maxTemp;
            self.dayFourLowTemp.text = minTemp;
            self.dayFourName.text = [format stringFromDate:dateTime];
        }];
        day = dailyForecast[5];
        time = [day[@"time"] integerValue];
        dateTime = [NSDate dateWithTimeIntervalSince1970:time];
        maxTemp = [NSString stringWithFormat:@"High: %@F",day[@"temperatureMax"]];
        minTemp = [NSString stringWithFormat:@"Low: %@F",day[@"temperatureMin"]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.dayFiveHighTemp.text = maxTemp;
            self.dayFiveLowTemp.text = minTemp;
            self.dayFiveName.text = [format stringFromDate:dateTime];
        }];
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
