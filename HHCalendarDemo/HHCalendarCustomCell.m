//
//  HHCalendarCustomCell.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/24.
//

#import "HHCalendarCustomCell.h"
#import "HHCalendarCustomCellModel.h"
#import <HHCommon/HHCommon.h>

#define mCircleInset mAdapter(6)

@interface HHCalendarCustomCell ()

@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UIView *rightLineView;

@end

@implementation HHCalendarCustomCell

- (void)ignoreSuperInitialInfo {}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.containerView.layer.cornerRadius = (self.contentView.width - mCircleInset * 2) / 2;
}

- (void)setupSubviews {
    [self.contentView hh_addView:^(UIView * _Nonnull view) {
        self.leftLineView = view;
        view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    }];
    
    [self.contentView hh_addView:^(UIView * _Nonnull view) {
        self.rightLineView = view;
        view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    }];
    
    [self.contentView hh_addView:^(UIView * _Nonnull view) {
        self.containerView = view;
        view.backgroundColor = [UIColor redColor];
    }];
    
    [self.containerView hh_addLabel:^(UILabel * _Nonnull label) {
        self.titleLabel = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkTextColor];
        label.font = mSystemBoldFont(mAdapter(16));
    }];
}

- (void)setupConstraints {
    self.leftLineView.left_.centY_.on_();
    self.leftLineView.heit_.equalTo(self.containerView).on_();
    self.leftLineView.widt_.equalTo(self.contentView).mult_(0.5).on_();
    
    self.rightLineView.righ_.centY_.on_();
    self.rightLineView.heit_.equalTo(self.containerView).on_();
    self.rightLineView.widt_.equalTo(self.contentView).mult_(0.5).on_();
    
    self.containerView.insetFrame_(UIEdgeInsetsMake(mCircleInset, mCircleInset, mCircleInset, mCircleInset));

    self.titleLabel.around_();
}

- (void)updateCellWithModel:(HHCalendarBaseCellModel *)model {
    HHCalendarCustomCellModel *cellModel = (HHCalendarCustomCellModel *)[model hh_as:HHCalendarCustomCellModel.class];
    if (cellModel == nil) {
        return;
    }
    self.titleLabel.text = model.titleString;
    if (cellModel.isSelected) {
        self.containerView.backgroundColor = cellModel.selectedBackgroundColor;
        self.titleLabel.textColor = cellModel.selectedTextColor;
    } else {
        self.containerView.backgroundColor = cellModel.normalBackgroundColor;
        self.titleLabel.textColor = cellModel.normalTextColor;
    }
    
    self.leftLineView.backgroundColor = cellModel.lineColor;
    self.rightLineView.backgroundColor = cellModel.lineColor;
    self.leftLineView.hidden = !cellModel.shouldShowLeftLine;
    self.rightLineView.hidden = !cellModel.shouldShowRightLine;
    if (cellModel.lineHeight > 0) {
        self.leftLineView.heit_.offset_(cellModel.lineHeight).on_();
        self.rightLineView.heit_.offset_(cellModel.lineHeight).on_();
    }
    if (model.isInCurrentMonth) {
        self.contentView.alpha = 1;
    } else {
        self.titleLabel.alpha = 1;
        self.contentView.alpha = 0.4;
        if (model.shouldShowPlaceholder == NO) {
            self.contentView.alpha = 0;
        }
    }
}

@end
