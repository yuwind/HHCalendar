//
//  HHCalendarCustomCellModel.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/24.
//

#import "HHCalendarBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarCustomCellModel : HHCalendarBaseCellModel

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) BOOL shouldShowLeftLine;
@property (nonatomic, assign) BOOL shouldShowRightLine;

@end

NS_ASSUME_NONNULL_END
