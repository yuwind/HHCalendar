//
//  HHCalendarDataProvider.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarDataProvider.h"
#import <HHCommon/HHCommon.h>

@interface HHCalendarDataProvider ()

@property (nonatomic, strong) HHCalendarContentConfig *config;
@property (nonatomic, assign) NSInteger numberOfSections;
@property (nonatomic, assign) NSInteger numberOfItemsInSection;
@property (nonatomic, assign) NSInteger numberOfRows;
@property (nonatomic, copy) NSDate *triggerDate;
@property (nonatomic, copy) NSDate *startDate;

@end

@implementation HHCalendarDataProvider

- (instancetype)initWithConfig:(HHCalendarContentConfig *)config {
    if (self = [super init]) {
        _config = config;
        _triggerDate = config.triggerDate;
        [self calculateData];
        [self bindingBlockInfo];
    }
    return self;
}

- (void)calculateData {
    self.numberOfSections = 1;
    if (self.config.calendarStyle == HHCalendarStyleWeek) {
        self.numberOfRows = 1;
        self.numberOfItemsInSection = 7;
        NSDate *firstDateInWeek = self.triggerDate.hh_firstDateInWeek;
        NSInteger week = firstDateInWeek.hh_week;
        self.startDate = [firstDateInWeek hh_dateOffset:1-week];
        return;
    }
    self.numberOfRows = self.triggerDate.hh_weeksInMonth;
    self.numberOfItemsInSection = self.numberOfRows * 7;
    NSDate *firstDateInMonth = self.triggerDate.hh_firstDateInMonth;
    NSInteger week = firstDateInMonth.hh_week;
    self.startDate = [firstDateInMonth hh_dateOffset:1-week];
}

- (void)bindingBlockInfo {
    @weakly(self);
    self.config.binding(@selector(setCalendarStyle:), ^{
        @strongly(self);
        [self calculateData];
        if (self.styleChangedBlock) {
            self.styleChangedBlock();
        }
    });
    self.config.binding(@selector(setTriggerDate:), ^{
        @strongly(self);
        self.triggerDate = self.config.triggerDate;
        [self dateChangedAction];
    });
}

- (void)previousAction {
    if (self.config.calendarStyle == HHCalendarStyleMonth) {
        self.triggerDate = [self.triggerDate hh_monthOffset:-1];
    } else {
        self.triggerDate = [self.triggerDate hh_weekOffset:-1];
    }
    [self dateChangedAction];
}

- (void)nextAction {
    if (self.config.calendarStyle == HHCalendarStyleMonth) {
        self.triggerDate = [self.triggerDate hh_monthOffset:1];
    } else {
        self.triggerDate = [self.triggerDate hh_weekOffset:1];
    }
    [self dateChangedAction];
}

- (void)backToToday {
    self.config.triggerDate = [NSDate date];
    self.triggerDate = [NSDate date];
    [self dateChangedAction];
}

- (void)backToTriggerDate {
    self.triggerDate = self.config.triggerDate;
    [self dateChangedAction];
}

- (void)dateChangedAction {
    [self calculateData];
    if (self.dateChangedBlock) {
        self.dateChangedBlock();
    }
}

- (BOOL)isCurrentMonthWithDate:(NSDate *)date {
    NSInteger triggerMonth = [self.triggerDate hh_month];
    NSInteger dateMonth = [date hh_month];
    return triggerMonth == dateMonth;
}

- (BOOL)isAfterTodayWithDate:(NSDate *)date {
    return [date timeIntervalSinceDate:[NSDate date]] > 0 && [date hh_isToday] == NO;
}

- (BOOL)isTodayWithDate:(NSDate *)date {
    return [date hh_isToday];
}

@end
