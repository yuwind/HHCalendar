//
//  HHCalendarConfig.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarBaseConfig.h"
#import "HHCalendarHeaderConfig.h"
#import "HHCalendarWeekConfig.h"
#import "HHCalendarContentConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarConfig : HHCalendarBaseConfig

@property (nonatomic, strong) HHCalendarHeaderConfig *headerConfig;
@property (nonatomic, strong) HHCalendarWeekConfig *weekConfig;
@property (nonatomic, strong) HHCalendarContentConfig *contentConfig;
@property (nonatomic, assign) BOOL shouldShowHeaderView;//default YES
@property (nonatomic, assign) CGFloat headerHeight;//default 40;
@property (nonatomic, assign) CGFloat headerWeekViewMargin;//default 8
@property (nonatomic, assign) BOOL shouldShowWeekView;//default YES
@property (nonatomic, assign) CGFloat weekViewHeight;//default 20
@property (nonatomic, assign) CGFloat weekContentViewMargin;//default 8

@end

NS_ASSUME_NONNULL_END
