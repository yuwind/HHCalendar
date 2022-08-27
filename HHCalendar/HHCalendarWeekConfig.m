//
//  HHCalendarWeekConfig.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarWeekConfig.h"
#import <HHCommon/HHCommon.h>

@implementation HHCalendarWeekConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _titleArray = @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
        _textColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.6];
        _textFont = [UIFont systemFontOfSize:13];
        _textAlignment = NSTextAlignmentCenter;
        _textSpacing = 0;
    }
    return self;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    _titleArray = titleArray;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    [self triggerBindingBlockIfNeeded:_cmd];
}

- (void)setTextSpacing:(CGFloat)textSpacing {
    _textSpacing = textSpacing;
    [self triggerBindingBlockIfNeeded:_cmd];
}

@end
