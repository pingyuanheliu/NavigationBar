//
//  UINavigationBar+XRColor.h
//  XRNavigationBar
//
//  Created by LL on 2019/10/28.
//  Copyright © 2019 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (XRColor)

/**
 设置导航栏颜色
 
 @param color 颜色值
 */
- (void)xr_setBarColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
