//
//  HHCalendarWeekView.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import <UIKit/UIKit.h>
#import "HHCalendarWeekConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarWeekView : UIView

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame config:(HHCalendarWeekConfig *)config;

@end

NS_ASSUME_NONNULL_END
