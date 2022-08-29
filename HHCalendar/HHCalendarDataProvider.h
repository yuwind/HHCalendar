//
//  HHCalendarDataProvider.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import <Foundation/Foundation.h>
#import "HHCalendarContentConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarDataProvider : NSObject

@property (nonatomic, assign, readonly) NSInteger numberOfSections;
@property (nonatomic, assign, readonly) NSInteger numberOfItemsInSection;
@property (nonatomic, assign, readonly) NSInteger numberOfRows;
@property (nonatomic, copy, readonly) NSDate *startDate;
@property (nonatomic, copy, readonly) NSDate *triggerDate;
@property (nonatomic, copy) void(^styleChangedBlock)(void);
@property (nonatomic, copy) void(^dateChangedBlock)(void);

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithConfig:(HHCalendarContentConfig *)config;
- (void)previousAction;
- (void)nextAction;
- (void)backToToday;
- (void)backToTriggerDate;

- (BOOL)isCurrentMonthWithDate:(NSDate *)date;
- (BOOL)isAfterTodayWithDate:(NSDate *)date;
- (BOOL)isTodayWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
