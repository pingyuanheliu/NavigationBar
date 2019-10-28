//
//  UIImage+XRColor.m
//  XRNavigationBar
//
//  Created by LL on 2019/10/28.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UIImage+XRColor.h"

@implementation UIImage (XRColor)

#pragma mark - Color Change To Image

/**
 颜色值转变成图片对象

 @param color 颜色值
 @return 图片对象
 */
+ (UIImage *)xr_imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 设置图形上下文的透明度
    CGContextSetAlpha(context, 1.0);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

@end
