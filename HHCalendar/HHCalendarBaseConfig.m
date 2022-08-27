//
//  HHCalendarBaseConfig.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/24.
//

#import "HHCalendarBaseConfig.h"

@interface HHCalendarBaseConfig ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, BindingBlock> *dictionaryM;

@end

@implementation HHCalendarBaseConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _dictionaryM = @{}.mutableCopy;
    }
    return self;
}

- (void (^)(SEL _Nonnull, BindingBlock _Nonnull))binding {
    return ^(SEL selector, BindingBlock action) {
        NSString *key = NSStringFromSelector(selector);
        [self.dictionaryM setObject:action forKey:key];
    };
}

- (BindingBlock  _Nonnull (^)(SEL _Nonnull))resolving {
    return ^BindingBlock (SEL selector) {
        NSString *key = NSStringFromSelector(selector);
        return [self.dictionaryM objectForKey:key];
    };
}

- (void)triggerBindingBlockIfNeeded:(SEL)selector {
    BindingBlock block = self.resolving(selector);
    if (block) {
        block();
    }
}

@end
