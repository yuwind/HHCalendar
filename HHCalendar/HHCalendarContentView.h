//
//  HHCalendarContentView.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import <UIKit/UIKit.h>
#import "HHCalendarContentConfig.h"
#import "HHCalendarDataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@class HHCalendarBaseCell;
@interface HHCalendarContentView : UIView

@property (nonatomic, strong, readonly) HHCalendarContentConfig *config;
@property (nonatomic, copy) void(^styleChangedAction)(void);
@property (nonatomic, copy) void(^didSelectItemBlock)(HHCalendarBaseCell *cell);

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame config:(HHCalendarContentConfig *)config dataProvider:(HHCalendarDataProvider *)dataProvider;
- (CGSize)contentViewSize;
- (void)beforePreviousAction;
- (void)afterPreviousAction;
- (void)beforeNextAction;
- (void)afterNextAction;

@end

NS_ASSUME_NONNULL_END
