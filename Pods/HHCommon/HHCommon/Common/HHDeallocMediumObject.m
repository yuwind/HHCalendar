//
//  HHDeallocMediumObject.m
//  HHCommonDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "HHDeallocMediumObject.h"

@interface HHDeallocMediumObject ()

@property (nonatomic, copy) void(^callBack)(void);

@end

@implementation HHDeallocMediumObject

+ (instancetype)mediumObjectWithCallBack:(void (^)(void))callBack {
    HHDeallocMediumObject *object = [HHDeallocMediumObject new];
    object.callBack = callBack;
    return object;
}

- (void)dealloc {
    if (self.callBack) {
        self.callBack();
    }
}

@end
