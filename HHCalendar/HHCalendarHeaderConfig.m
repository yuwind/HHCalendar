//
//  HHCalendarHeaderConfig.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/25.
//

#import "HHCalendarHeaderConfig.h"
#import <HHCommon/HHCommon.h>

@implementation HHCalendarHeaderConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _previousImageName = @"hh_calendar_previous";
        _nextImageName = @"hh_calendar_next";
        _dateFormat = @"MMM yyyy";
        _titleColor = [UIColor darkTextColor];
        _titleFont = mSystemBoldFont(18);
        _shouldShowNextMonthAfterToday = YES;
    }
    return self;
}

- (void)setPreviousImageName:(NSString *)previousImageName {
    _previousImageName = previousImageName;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setNextImageName:(NSString *)nextImageName {
    _nextImageName = nextImageName;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setDateFormat:(NSString *)dateFormat {
    _dateFormat = dateFormat;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    [self triggerBindingBlockIfNeeded:_cmd];
}

@end
