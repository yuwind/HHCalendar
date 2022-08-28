//
//  HHCalendarConfig.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarConfig.h"
#import <HHCommon/HHCommon.h>

@implementation HHCalendarConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _headerConfig = [HHCalendarHeaderConfig new];
        _weekConfig = [HHCalendarWeekConfig new];
        _contentConfig = [HHCalendarContentConfig new];
        _shouldShowHeaderView = YES;
        _headerHeight = ceil(mAdapter(44));
        _headerWeekViewMargin = ceil(mAdapter(8));
        _shouldShowWeekView = YES;
        _weekViewHeight = ceil(mAdapter(20));
        _weekContentViewMargin = ceil(mAdapter(8));
    }
    return self;
}

- (void)setShouldShowHeaderView:(BOOL)shouldShowHeaderView {
    _shouldShowHeaderView = shouldShowHeaderView;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    _headerHeight = headerHeight;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setHeaderWeekViewMargin:(CGFloat)headerWeekViewMargin {
    _headerWeekViewMargin = headerWeekViewMargin;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setShouldShowWeekView:(BOOL)shouldShowWeekView {
    _shouldShowWeekView = shouldShowWeekView;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setWeekViewHeight:(CGFloat)weekViewHeight {
    _weekViewHeight = weekViewHeight;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setWeekContentViewMargin:(CGFloat)weekContentViewMargin {
    _weekContentViewMargin = weekContentViewMargin;
    [self triggerBindingBlockIfNeeded:_cmd];
}

@end
