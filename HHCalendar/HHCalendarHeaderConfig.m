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
        _textColor = [UIColor darkTextColor];
        _textFont = mSystemBoldFont(18);
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

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setDateFormatter:(NSDateFormatter *)dateFormatter {
    _dateFormatter = dateFormatter;
    [self triggerBindingBlockIfNeeded:_cmd];
}

@end
