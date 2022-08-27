//
//  HHCalendarWeekView.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarWeekView.h"
#import <HHCommon/HHCommon.h>

@interface HHCalendarWeekView ()

@property (nonatomic, strong) HHCalendarWeekConfig *config;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, copy) NSArray<UILabel *> *labelArray;

@end

@implementation HHCalendarWeekView

- (instancetype)initWithFrame:(CGRect)frame config:(HHCalendarWeekConfig *)config {
    if (self = [super initWithFrame:frame]) {
        _config = config;
        [self setupSubviews];
        [self bindingBlockInfo];
    }
    return self;
}

- (void)setupSubviews {
    NSArray *titleArray = self.config.titleArray;
    NSMutableArray *arrayM = @[].mutableCopy;
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *label = [UILabel new];
        label.textColor = self.config.textColor;
        label.textAlignment = self.config.textAlignment;
        label.font = self.config.textFont;
        label.text = [titleArray hh_objectSafelyAtIndex:i];
        [arrayM hh_addObjectSafely:label];
    }
    self.labelArray = arrayM.copy;
    
    self.stackView = [[UIStackView alloc] initWithArrangedSubviews:arrayM.copy];
    [self addSubview:self.stackView];
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    self.stackView.spacing = self.config.textSpacing;
    self.stackView.around_();
}

- (void)updateSubviewsInfo {
    NSArray *titleArray = self.config.titleArray;
    for (NSInteger i = 0; i < self.labelArray.count; i++) {
        UILabel *label = [self.labelArray hh_objectSafelyAtIndex:i];
        label.textColor = self.config.textColor;
        label.textAlignment = self.config.textAlignment;
        label.font = self.config.textFont;
        label.text = [titleArray hh_objectSafelyAtIndex:i];
    }
    self.stackView.spacing = self.config.textSpacing;
}

- (void)bindingBlockInfo {
    @weakly(self);
    self.config.binding(@selector(setTitleArray:), ^{
        @strongly(self);
        [self updateSubviewsInfo];
    });
    self.config.binding(@selector(setTextColor:), ^{
        @strongly(self);
        [self updateSubviewsInfo];
    });
    self.config.binding(@selector(setTextFont:), ^{
        @strongly(self);
        [self updateSubviewsInfo];
    });
    self.config.binding(@selector(setTextAlignment:), ^{
        @strongly(self);
        [self updateSubviewsInfo];
    });
    self.config.binding(@selector(setTextSpacing:), ^{
        @strongly(self);
        [self updateSubviewsInfo];
    });
}

@end
