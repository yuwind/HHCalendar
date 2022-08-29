//
//  HHCalendarContentConfig.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarContentConfig.h"
#import <HHCommon/HHCommon.h>

@implementation HHCalendarContentConfig
@synthesize triggerDate = _triggerDate;

- (instancetype)init {
    self = [super init];
    if (self) {
        _triggerDate = [NSDate date];
        _calendarStyle = HHCalendarStyleMonth;
        _calendarWidth = floor(mScreenWidth - mAdapter(30) * 2);
        _lineSpacing = floor(mAdapter(8));
        _columnSpacing = floor(mAdapter(8));
        _shouldFixTriggerDate = YES;
        _shouldShowPlaceholder = YES;
        _shouldShowChangeAnimation = YES;
    }
    return self;
}

- (void)setCalendarStyle:(HHCalendarStyle)calendarStyle {
    _calendarStyle = calendarStyle;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setTriggerDate:(NSDate *)triggerDate {
    _triggerDate = triggerDate;
    [self triggerBindingBlockIfNeeded:_cmd];
    _shouldFixTriggerDate = [triggerDate hh_isSameDay:[NSDate date]];
}

- (NSDate *)triggerDate {
    if (self.shouldFixTriggerDate) {
        return [NSDate date];
    }
    return _triggerDate;
}

- (void)setCalendarWidth:(CGFloat)calendarWidth {
    _calendarWidth = calendarWidth;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setColumnSpacing:(CGFloat)columnSpacing {
    _columnSpacing = columnSpacing;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setShouldShowPlaceholder:(BOOL)shouldShowPlaceholder {
    _shouldShowPlaceholder = shouldShowPlaceholder;
    [self triggerBindingBlockIfNeeded:_cmd];
}

@end
