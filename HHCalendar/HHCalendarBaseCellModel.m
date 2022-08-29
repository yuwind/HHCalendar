//
//  HHCalendarBaseCellModel.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/24.
//

#import "HHCalendarBaseCellModel.h"
#import <HHCommon/HHCommon.h>

@implementation HHCalendarBaseCellModel

- (instancetype)init {
    self = [super init];
    if (self) {
       _reuseIdentifier = @"HHCalendarBaseCell";
    }
    return self;
}

- (void)setupCellModelWithDataProvider:(HHCalendarDataProvider *)dataProvider date:(NSDate *)date shouldShowPlaceholder:(BOOL)shouldShowPlaceholder {
    self.date = date;
    self.titleString = @(date.hh_day).stringValue;
    self.shouldShowPlaceholder = shouldShowPlaceholder;
    [self setupBaseInfoWithDataProvider:dataProvider date:date];
}

- (void)setupCacheModelWithDataProvider:(HHCalendarDataProvider *)dataProvider date:(NSDate *)date {
    [self setupBaseInfoWithDataProvider:dataProvider date:date];
}

- (void)setupBaseInfoWithDataProvider:(HHCalendarDataProvider *)dataProvider date:(NSDate *)date {
    self.isInCurrentMonth = [dataProvider isCurrentMonthWithDate:date];
    self.isToday = [dataProvider isTodayWithDate:date];
    self.isAfterToday = [dataProvider isAfterTodayWithDate:date];
}

@end
