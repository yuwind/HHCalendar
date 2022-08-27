//
//  HHCalendarCustomCellModel.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/24.
//

#import "HHCalendarCustomCellModel.h"
#import <HHCommon/HHCommon.h>

@interface HHCalendarCustomCellModel ()

@property (nonatomic, strong) HHCalendarDataProvider *dataProvider;

@end

static NSMutableDictionary *_dictionaryM = nil;

@implementation HHCalendarCustomCellModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reuseIdentifier = @"HHCalendarCustomCell";
    }
    return self;
}

- (void)setupCellModelWithDataProvider:(HHCalendarDataProvider *)dataProvider date:(NSDate *)date shouldShowPlaceholder:(BOOL)shouldShowPlaceholder {
    [super setupCellModelWithDataProvider:dataProvider date:date shouldShowPlaceholder:shouldShowPlaceholder];
    self.dataProvider = dataProvider;
    self.normalBackgroundColor = [UIColor clearColor];
    self.selectedBackgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    self.normalTextColor = [UIColor darkTextColor];
    self.selectedTextColor = [UIColor whiteColor];
    self.lineColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    self.lineHeight = mAdapter(20);
    
    [self setupConfigInfoWithDate:date];
}

- (void)setupConfigInfoWithDate:(NSDate *)date {
    if ([self containDate:date]) {
        self.isSelected = YES;
        NSDate *yestoday = [date hh_dateOffset:-1];
        if ([self containDate:yestoday]) {
            self.shouldShowLeftLine = YES;
        } else {
            self.shouldShowLeftLine = NO;
        }
        NSDate *tomorrow = [date hh_dateOffset:1];
        if ([self containDate:tomorrow]) {
            self.shouldShowRightLine = YES;
        } else {
            self.shouldShowRightLine = NO;
        }
    } else {
        self.isSelected = NO;
        self.shouldShowLeftLine = NO;
        self.shouldShowRightLine = NO;
    }
    if (date.hh_week == 1) {
        self.shouldShowLeftLine = NO;
    } else if (date.hh_week == 7) {
        self.shouldShowRightLine = NO;
    }
    if ([date hh_isFirstDateInMonth]) {
        self.shouldShowLeftLine = NO;
    } else if ([date hh_isLastDateInMonth]) {
        self.shouldShowRightLine = NO;
    }
}

- (BOOL)containDate:(NSDate *)date {
    NSString *dateString = date.hh_toString;
    NSArray *dateArray = [self generalSelectedDateArray];
    return [dateArray containsObject:dateString];
}

- (NSArray *)generalSelectedDateArray {
    if (_dictionaryM == nil) {
        _dictionaryM = @{}.mutableCopy;
    }
    NSDate *firstDate = self.dataProvider.startDate;
    NSString *cacheKey = [firstDate hh_stringWithDateFormat:@"yyyyMM"];
    NSArray *cacheArray = [_dictionaryM hh_arrayForKeySafely:cacheKey];
    if (cacheArray.count > 0) {
        return cacheArray;
    }
    NSMutableArray *arrayM = @[].mutableCopy;
    while (arrayM.count < 15) {
        NSInteger count = [firstDate hh_daysInMonth];
        NSInteger random = arc4random_uniform((uint32_t)count);
        NSDate *randomDate = [firstDate hh_dateOffset:random];
        NSString *dateString = randomDate.hh_toString;
        if ([arrayM containsObject:dateString]) {
            continue;
        } else {
            [arrayM addObject:dateString];
        }
    }
    [_dictionaryM hh_setObjectSafely:arrayM.copy forKey:cacheKey];
    return arrayM.copy;
}

@end
