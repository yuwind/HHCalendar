//
//  HHCalendarHeaderView.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/25.
//

#import "HHCalendarHeaderView.h"
#import <HHCommon/HHCommon.h>

@interface HHCalendarHeaderView ()

@property (nonatomic, strong) HHCalendarHeaderConfig *config;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, copy) NSDate *date;

@end

@implementation HHCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame config:(HHCalendarHeaderConfig *)config {
    if (self = [super initWithFrame:frame]) {
        _config = config;
        [self setupSubviews];
        [self setupConstraints];
        [self bindingBlockInfo];
    }
    return self;
}

- (void)setupSubviews {
    @weakly(self);
    [self hh_addButton:^(UIButton * _Nonnull button) {
        self.previousButton = button;
        UIImage *image = [self buttonImageWithImageName:self.config.previousImageName];
        [button setImage:image forState:UIControlStateNormal];
        button.adjustsImageWhenHighlighted = NO;
    } action:^(UIButton * _Nonnull sender) {
        @strongly(self);
        if (self.previousBlock) {
            self.previousBlock();
        }
    }];
    
    [self hh_addLabel:^(UILabel * _Nonnull label) {
        self.titleLabel = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.config.titleColor;
        label.font = self.config.titleFont;
        label.adjustsFontSizeToFitWidth = YES;
    }];
    
    [self hh_addButton:^(UIButton * _Nonnull button) {
        self.nextButton = button;
        UIImage *image = [self buttonImageWithImageName:self.config.nextImageName];
        [button setImage:image forState:UIControlStateNormal];
        button.adjustsImageWhenHighlighted = NO;
    } action:^(UIButton * _Nonnull sender) {
        @strongly(self);
        if (self.nextBlock) {
            self.nextBlock();
        }
    }];
}

- (void (^)(NSDate * _Nonnull))dateBlock {
    return ^(NSDate *date) {
        self.date = date;
        self.titleLabel.text = [date hh_stringWithDateFormat:self.config.dateFormat];
        if (self.config.shouldShowNextMonthAfterToday == NO) {
            NSDate *current = [NSDate date];
            NSInteger currentMonth = current.hh_month;
            NSInteger currentYear = current.hh_year;
            NSInteger month = date.hh_month;
            NSInteger year = date.hh_year;
            self.nextButton.hidden = (currentMonth == month && currentYear == year);
        }
    };
}

- (void)setupConstraints {
    self.previousButton.left_.centY_.on_();
    self.previousButton.size_.offset_(40).on_();
    
    self.nextButton.righ_.centY_.on_();
    self.nextButton.size_.equalTo(self.previousButton).on_();
    
    self.titleLabel.cent_.on_();
    self.titleLabel.left_.greatThan(self.previousButton.righ_).offset_(5).on_();
    self.titleLabel.righ_.lessThan(self.nextButton.left_).offset_(-5).on_();
}

- (void)bindingBlockInfo {
    @weakly(self);
    self.config.binding(@selector(setPreviousImageName:), ^{
        @strongly(self);
        [self.previousButton setImage:self.config.previousImageName.toImage forState:UIControlStateNormal];
    });
    self.config.binding(@selector(setNextImageName:), ^{
        @strongly(self);
        [self.nextButton setImage:self.config.nextImageName.toImage forState:UIControlStateNormal];
    });
    self.config.binding(@selector(setDateFormat:), ^{
        @strongly(self);
        self.dateBlock(self.date);
    });
    self.config.binding(@selector(setTitleColor:), ^{
        @strongly(self);
        self.titleLabel.textColor = self.config.titleColor;
    });
    self.config.binding(@selector(setTitleFont:), ^{
        @strongly(self);
        self.titleLabel.font = self.config.titleFont;
    });
}

- (UIImage *)buttonImageWithImageName:(NSString *)imageName {
    if (![imageName isEqualToString:@"hh_calendar_previous"] && ![imageName isEqualToString:@"hh_calendar_next"]) {
        return imageName.toImage;
    }
    NSBundle *mainBundle = [NSBundle bundleForClass:HHCalendarHeaderView.class];
    NSString *bundlePath = [mainBundle pathForResource:@"HHCalendarBundle.bundle" ofType:nil];
    NSString *extensionName = [UIScreen mainScreen].scale == 3 ? @"@3x.png" : @"@2x.png";
    NSString *resourceName = formatString(@"%@%@",imageName, extensionName);
    NSString *imagePath = [[NSBundle bundleWithPath:bundlePath] pathForResource:resourceName ofType:nil];
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
