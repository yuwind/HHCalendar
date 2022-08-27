//
//  NSDate+HHAdd.m
//  HHCommonDemo
//
//  Created by huxuewei on 2022/6/20.
//

#import "NSDate+HHAdd.h"

#define mDefaultDateFormat @"yyyy-MM-dd"

NSDateFormatter * dateFormatterInstance(void) {
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    });
    return _dateFormatter;
}

NSCalendar * calendarInstance(void) {
    static NSCalendar *_calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    });
    return _calendar;
}

@implementation NSDate (HHAdd)

- (BOOL)hh_isToday {
    return [self hh_isSameDay:[NSDate date]];
}

- (BOOL)hh_isYestoday {
    return [[self dateByAddingTimeInterval:mOneDaySeconds] hh_isToday];
}

- (BOOL)hh_isTomorrow {
    return [[self dateByAddingTimeInterval:-mOneDaySeconds] hh_isToday];
}

- (BOOL)hh_isSameDay:(NSDate *)date {
    return ([date hh_year] == [self hh_year]) && ([date hh_month] == [self hh_month]) && ([date hh_day] == [self hh_day]);
}

- (BOOL)hh_isFirstDateInMonth {
    NSDate *firstDate = [self hh_firstDateInMonth];
    return [self hh_isSameDay:firstDate];
}

- (BOOL)hh_isLastDateInMonth {
    NSDate *lastDate = [self hh_lastDateInMonth];
    return [self hh_isSameDay:lastDate];
}

- (BOOL)hh_isFirstDateInWeek {
    NSDate *firstDate = [self hh_firstDateInWeek];
    return [self hh_isSameDay:firstDate];
}

- (BOOL)hh_isLastDateInWeek {
    NSDate *lastDate = [self hh_lastDateInWeek];
    return [self hh_isSameDay:lastDate];
}

- (NSInteger)hh_year {
    return [self hh_dateComponentWithUnit:NSCalendarUnitYear];
}

- (NSInteger)hh_month {
    return [self hh_dateComponentWithUnit:NSCalendarUnitMonth];
}

- (NSInteger)hh_day {
    return [self hh_dateComponentWithUnit:NSCalendarUnitDay];
}

- (NSInteger)hh_hour {
    return [self hh_dateComponentWithUnit:NSCalendarUnitHour];
}

- (NSInteger)hh_minute {
    return [self hh_dateComponentWithUnit:NSCalendarUnitMinute];
}

- (NSInteger)hh_second {
    return [self hh_dateComponentWithUnit:NSCalendarUnitSecond];
}

- (NSInteger)hh_week {
    return [self hh_dateComponentWithUnit:NSCalendarUnitWeekday];
}

- (NSString *)hh_toString {
    return [self hh_stringWithDateFormat:mDefaultDateFormat];
}

- (NSString *)hh_stringWithDateFormat:(NSString *)dateFormat {
    if (dateFormat.length == 0) {
        return nil;
    }
    NSDateFormatter *formatter = dateFormatterInstance();
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:self];
}

- (NSInteger)hh_dayCountSinceDate:(NSDate *)date {
    if (date == nil) {
        return 0;
    }
    NSTimeInterval interval = [self timeIntervalSinceDate:date];
    return interval / mOneDaySeconds;
}

- (NSInteger)hh_daysInMonth {
    NSCalendar *calendar = calendarInstance();
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSInteger)hh_daysInYear {
    NSCalendar *calendar = calendarInstance();
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
    return range.length;
}

- (NSInteger)hh_dayIndexInWeek {
    NSCalendar *calendar = calendarInstance();
    return [calendar component:NSCalendarUnitWeekday fromDate:self];
}

- (NSInteger)hh_dayIndexInMonth {
    NSCalendar *calendar = calendarInstance();
    return [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
}

- (NSInteger)hh_dayIndexInYear {
    NSCalendar *calendar = calendarInstance();
    return [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
}

- (NSDate *)hh_firstDateInWeek {
    NSCalendar *calendar = calendarInstance();
    NSDate *beginningOfWeek = nil;
    BOOL isSuccess = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&beginningOfWeek interval:NULL forDate:self];
    if (isSuccess) {
        return beginningOfWeek;
    }
    return nil;
}

- (NSDate *)hh_lastDateInWeek {
    NSDate *firstDate = [self hh_firstDateInWeek];
    return [firstDate dateByAddingTimeInterval:6*mOneDaySeconds];
}

- (NSDate *)hh_firstDateInMonth {
    NSCalendar *calendar = calendarInstance();
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.day = 1;
    return [calendar dateFromComponents:components];
}

- (NSDate *)hh_lastDateInMonth {
    NSCalendar *calendar = calendarInstance();
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.month++;
    components.day = 0;
    return [calendar dateFromComponents:components];
}

- (NSDate *)hh_weekOffset:(NSInteger)offset {
    NSCalendar *calendar = calendarInstance();
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setWeekOfMonth:offset];
    return [calendar dateByAddingComponents:offsetComponents toDate:self options:0];
}

- (NSInteger)hh_weeksInMonth {
    NSCalendar *calendar = calendarInstance();
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSInteger)hh_weeksInYear {
    NSCalendar *calendar = calendarInstance();
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
    return range.length;
}

- (NSDate *)hh_dateOffset:(NSInteger)offset {
    NSCalendar *calendar = calendarInstance();
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:offset];
    return [calendar dateByAddingComponents:offsetComponents toDate:self options:0];
}

- (NSDate *)hh_monthOffset:(NSInteger)offset {
    NSCalendar *calendar = calendarInstance();
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:offset];
    return [calendar dateByAddingComponents:offsetComponents toDate:self options:0];
}

- (NSDate *)hh_yearOffset:(NSInteger)offset {
    NSCalendar *calendar = calendarInstance();
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:offset];
    return [calendar dateByAddingComponents:offsetComponents toDate:self options:0];
}

#pragma private

- (NSInteger)hh_dateComponentWithUnit:(NSCalendarUnit)unit {
    NSCalendar *calendar = calendarInstance();
    NSDateComponents *components = [calendar components:unit fromDate:self];
    switch (unit) {
        case NSCalendarUnitEra:
            return components.era;
        case NSCalendarUnitYear:
            return components.year;
        case NSCalendarUnitMonth:
            return components.month;
        case NSCalendarUnitDay:
            return components.day;
        case NSCalendarUnitHour:
            return components.hour;
        case NSCalendarUnitMinute:
            return components.minute;
        case NSCalendarUnitSecond:
            return components.second;
        case NSCalendarUnitWeekday:
            return components.weekday;
        default:
            return HHNotFound;
    }
}

@end

@implementation NSString (HHDate)

- (NSDate *)hh_toDate {
    return [self hh_dateWithDateFormat:mDefaultDateFormat];
}

- (NSDate *)hh_dateWithDateFormat:(NSString *)dateFormat {
    if (dateFormat.length == 0) {
        return nil;
    }
    NSDateFormatter *formatter = dateFormatterInstance();
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:self];
}

@end
