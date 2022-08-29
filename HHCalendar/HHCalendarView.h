//
//  HHCalendarView.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import <UIKit/UIKit.h>
#import "HHCalendarConfig.h"
#import "HHCalendarDataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@class HHCalendarBaseCell;
@interface HHCalendarView : UIView

@property (nonatomic, strong, readonly) HHCalendarConfig *config;
@property (nonatomic, strong, readonly) HHCalendarDataProvider *dataProvider;
@property (nonatomic, copy) void(^didSelectItemBlock)(HHCalendarBaseCell *cell);
@property (nonatomic, copy) void(^didClickHeaderDateBlock)(NSDate *date);

+ (instancetype)createCalendarView:(void(^ _Nullable)(HHCalendarConfig * config))configBlock;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (void)toggleCalenderStyle;
- (void)previousAction;
- (void)nextAction;
- (void)backToToday;
- (void)backToTriggerDate;

@end

NS_ASSUME_NONNULL_END
