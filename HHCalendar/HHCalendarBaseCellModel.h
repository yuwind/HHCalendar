//
//  HHCalendarBaseCellModel.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/24.
//

#import <Foundation/Foundation.h>
#import "HHCalendarDataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHCalendarBaseCellModel : NSObject

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, assign) BOOL isInCurrentMonth;
@property (nonatomic, assign) BOOL isToday;
@property (nonatomic, assign) BOOL isAfterToday;
@property (nonatomic, assign) BOOL shouldShowPlaceholder;
@property (nonatomic, copy) NSString *reuseIdentifier;

- (void)setupCellModelWithDataProvider:(HHCalendarDataProvider *)dataProvider date:(NSDate *)date shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)setupCacheModelWithDataProvider:(HHCalendarDataProvider *)dataProvider date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
