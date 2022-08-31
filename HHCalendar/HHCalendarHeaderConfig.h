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
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) BOOL shouldShowNextMonthAfterToday;//default YES
@property (nonatomic, strong, nullable) NSDateFormatter *dateFormatter;

@end

NS_ASSUME_NONNULL_END
