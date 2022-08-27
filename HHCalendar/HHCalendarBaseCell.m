//
//  HHCalendarBaseCell.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarBaseCell.h"
#import <HHCommon/HHCommon.h>

@implementation HHCalendarBaseCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self ignoreSuperInitialInfo];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    [self ignoreSuperInitialInfo];
}

- (void)ignoreSuperInitialInfo {
    if (self.containerView == nil) {
        self.containerView = [UIView new];
        [self.contentView addSubview:self.containerView];
        self.containerView.backgroundColor = mRGBColor(122, 125, 254);
        self.containerView.layer.cornerRadius = 6;
        self.containerView.layer.masksToBounds = YES;
        self.containerView.around_();
    }
    if (self.titleLabel == nil) {
        self.titleLabel = [UILabel new];
        [self.containerView addSubview:self.titleLabel];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.around_().on_();
    }
    self.containerView.layer.cornerRadius = self.contentView.width / 2;
}

- (void)updateCellWithModel:(HHCalendarBaseCellModel *)model {
    self.cellModel = model;
    self.titleLabel.text = model.titleString;
    self.containerView.hidden = NO;
    if (model.isInCurrentMonth) {
        self.containerView.alpha = 1;
    } else {
        self.containerView.alpha = 0.3;
        if (model.shouldShowPlaceholder == NO) {
            self.containerView.hidden = YES;
        }
    }
    if (model.isToday) {
        self.containerView.backgroundColor = mRGBColor(0, 118, 255);
    } else {
        self.containerView.backgroundColor = [UIColor clearColor];
    }
}

@end
