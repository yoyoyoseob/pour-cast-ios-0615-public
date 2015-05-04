//
//  FISDailyForecast.m
//  pour-cast
//
//  Created by Timothy Clem on 4/16/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISDailyForecast.h"

@implementation FISDailyForecast

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self) {
        NSInteger timeSeconds = [dictionary[@"time"] integerValue];
        _date = [NSDate dateWithTimeIntervalSince1970:timeSeconds];

        _temperatureMax = [dictionary[@"temperatureMax"] floatValue];
        _temperatureMin = [dictionary[@"temperatureMin"] floatValue];
    }

    return self;
}

-(NSUInteger)hash
{
    return [self.date hash];
}

-(BOOL)isEqual:(id)object
{
    if(self == object) return YES;
    if(![object isKindOfClass:self.class]) return NO;

    FISDailyForecast *other = (FISDailyForecast *)object;

    return [other.date isEqualToDate:self.date] &&
           other.temperatureMin == self.temperatureMin &&
           other.temperatureMax == self.temperatureMax;
}

@end
