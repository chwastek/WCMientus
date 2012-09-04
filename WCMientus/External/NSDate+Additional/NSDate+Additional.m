//
//  NSDate+Normalization.m
//  Ante-Up
//
//  Created by mientus on 11.07.2012.
//  Copyright (c) 2012 Ante Up. All rights reserved.
//

#import "NSDate+Additional.h"

@implementation NSDate (Additional)

- (NSDate *)normalizedDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate: self];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init] ;
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

- (NSDate *)yesterday
{
    return [NSDate dateWithTimeInterval:-(24*60*60) sinceDate:self];
    
}

- (NSDate *)dateAfterDays:(NSInteger)days
{
    return [NSDate dateWithTimeInterval:days*(24*60*60) sinceDate:self];
}

- (NSDate *)tommorow
{
    return [NSDate dateWithTimeInterval:(24*60*60) sinceDate:self];
}

-(NSDate *)toLocalTime
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

-(NSDate *)toGlobalTime
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = -[tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}


@end
