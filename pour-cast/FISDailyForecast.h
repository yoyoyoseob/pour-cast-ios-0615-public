//
//  FISDailyForecast.h
//  pour-cast
//
//  Created by Timothy Clem on 4/16/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISDailyForecast : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) float temperatureMax;
@property (nonatomic, assign) float temperatureMin;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
