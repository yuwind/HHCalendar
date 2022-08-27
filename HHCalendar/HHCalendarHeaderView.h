//
//  HHCalendarHeaderView.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/25.
//

#import <UIKit/UIKit.h>
#import "HHCalendarHeaderConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarHeaderView : UIView

@property (nonatomic, copy) void(^previousBlock)(void);
@property (nonatomic, copy) void(^nextBlock)(void);
@property (nonatomic, copy, readonly) void(^dateBlock)(NSDate *date);

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame config:(HHCalendarHeaderConfig *)config;

@end

NS_ASSUME_NONNULL_END
