//
//  UINavigationController+XR.h
//  XRNavigationBar
//
//  Created by LL on 2019/10/28.
//  Copyright © 2019 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (XR) <UINavigationControllerDelegate>

//是否使用子定义导航背景颜色
@property (nonatomic, assign) BOOL xr_useBarColor;

@end

NS_ASSUME_NONNULL_END
