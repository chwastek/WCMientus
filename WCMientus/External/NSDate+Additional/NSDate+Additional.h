//
//  NSDate+Normalization.h
//  Ante-Up
//
//  Created by mientus on 11.07.2012.
//  Copyright (c) 2012 Ante Up. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additional)

- (NSDate *)normalizedDate;

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSDate *)yesterday;
- (NSDate *)tommorow;

- (NSDate *)dateAfterDays:(NSInteger)days;

- (NSDate *)toLocalTime;
- (NSDate *)toGlobalTime;

@end
