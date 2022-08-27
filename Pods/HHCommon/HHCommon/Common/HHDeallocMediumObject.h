//
//  HHDeallocMediumObject.h
//  HHCommonDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHDeallocMediumObject : NSObject

+ (instancetype)mediumObjectWithCallBack:(void(^)(void))callBack;

@end

NS_ASSUME_NONNULL_END
