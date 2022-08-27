//
//  HHCalendarBaseCell.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import <UIKit/UIKit.h>
#import "HHCalendarBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarBaseCell : UICollectionViewCell

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) HHCalendarBaseCellModel *cellModel;

- (void)updateCellWithModel:(HHCalendarBaseCellModel *)model;
- (void)ignoreSuperInitialInfo;//need to override

@end

NS_ASSUME_NONNULL_END
