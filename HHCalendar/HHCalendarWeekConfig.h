//
//  HHCalendarWeekConfig.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarWeekConfig : HHCalendarBaseConfig

@property (nonatomic, copy) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) CGFloat textSpacing;

@end

NS_ASSUME_NONNULL_END
