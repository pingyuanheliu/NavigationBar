//
//  UIImage+XRColor.h
//  XRNavigationBar
//
//  Created by LL on 2019/10/28.
//  Copyright © 2019 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XRColor)

/**
 颜色值转变成图片对象
 
 @param color 颜色值
 @return 图片对象
 */
+ (UIImage *)xr_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
