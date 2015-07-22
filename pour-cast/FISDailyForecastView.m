//
//  FISDailyForecastView.m
//  pour-cast
//
//  Created by Yoseob Lee on 7/22/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISDailyForecastView.h"

@interface FISDailyForecastView ()

@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *highLabel;
@property (strong, nonatomic) IBOutlet UILabel *lowLabel;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@end

@implementation FISDailyForecastView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInIt];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInIt];
    }
    return self;
}

-(void)commonInIt
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:self.containerView];
}

-(void)setDailyForecast:(FISDailyForecast *)dailyForecast
{
    _dailyForecast = dailyForecast;
    [self updateUI];
}

-(void)updateUI
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd"];

    NSString *dateString = [format stringFromDate:self.dailyForecast.date];
    
    NSString *maxTemp = [NSString stringWithFormat:@"High: %.1fF", self.dailyForecast.temperatureMax];
    NSString *minTemp = [NSString stringWithFormat:@"Low: %.1fF", self.dailyForecast.temperatureMin];
    
    self.dayLabel.text = dateString;
    self.highLabel.text = maxTemp;
    self.lowLabel.text = minTemp;
}


@end
