//
//  HHCalendarHeaderConfig.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/25.
//

#import "HHCalendarBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarHeaderConfig : HHCalendarBaseConfig

@property (nonatomic, copy) NSString *previousImageName;
@property (nonatomic, copy) NSString *nextImageName;
@property (nonatomic, copy) NSString *dateFormat;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) BOOL shouldShowNextMonthAfterToday;//default YES

@end

NS_ASSUME_NONNULL_END
