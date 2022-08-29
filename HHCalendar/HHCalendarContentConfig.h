//
//  HHCalendarContentConfig.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarBaseConfig.h"

typedef NS_ENUM(NSUInteger, HHCalendarStyle) {
    HHCalendarStyleMonth,
    HHCalendarStyleWeek,
};

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarContentConfig : HHCalendarBaseConfig

@property (nonatomic, assign) BOOL shouldFixTriggerDate;//default YES
@property (nonatomic, copy) NSDate *triggerDate;//default [NSDate date]
@property (nonatomic, assign) HHCalendarStyle calendarStyle;//default month
@property (nonatomic, assign) CGFloat calendarWidth;//default screen width - 60
@property (nonatomic, assign) CGFloat lineSpacing;//default 8
@property (nonatomic, assign) CGFloat columnSpacing;//default 8
@property (nonatomic, assign) BOOL shouldShowPlaceholder;//default YES
@property (nonatomic, assign) BOOL shouldShowChangeAnimation;//default YES

@property (nonatomic, copy, nullable) NSArray *cellClassArray;//default nil
@property (nonatomic, strong, nullable) Class cellModelClass;//default nil

@end

NS_ASSUME_NONNULL_END
