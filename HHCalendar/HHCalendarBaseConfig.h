//
//  HHCalendarBaseConfig.h
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BindingBlock)(void);

@interface HHCalendarBaseConfig : NSObject

@property (nonatomic, copy, readonly) void(^binding)(SEL selector, BindingBlock action);
@property (nonatomic, copy, readonly) BindingBlock(^resolving)(SEL selector);
- (void)triggerBindingBlockIfNeeded:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
