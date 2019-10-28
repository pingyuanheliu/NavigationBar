//
//  UINavigationBar+XRColor.m
//  XRNavigationBar
//
//  Created by LL on 2019/10/28.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UINavigationBar+XRColor.h"
#import <objc/runtime.h>

@interface UINavigationBar ()

@property (strong, nonatomic) UIImageView *bgImgV;

@end

@implementation UINavigationBar (XRColor)

+ (void)initialize {
    if (self == [UINavigationBar class]) {
        // 交换方法
        SEL originalSelector = @selector(didMoveToWindow);
        SEL swizzledSelector = @selector(xr_didMoveToWindow);
        // 转换Method
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        // 判断方法是否存在
        BOOL success = class_addMethod([self class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod([self class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

#pragma mark - Swizzled method

- (void)xr_didMoveToWindow
{
    [self xr_didMoveToWindow];
    if (self.bgImgV == nil) {
        CGRect rect = self.bounds;
        CGFloat margin;
        if (@available(iOS 11.0, *)) {
            UIWindow *window = [[UIApplication sharedApplication] delegate].window;
            UIEdgeInsets insets = window.safeAreaInsets;
            margin = MAX(20.0, insets.top);
        }else {
            margin = 20.0;
        }
        rect.origin.y = -margin;
        rect.size.height += margin;
        self.bgImgV = [[UIImageView alloc] initWithFrame:rect];
        self.bgImgV.backgroundColor = [UIColor clearColor];
        [self insertSubview:self.bgImgV atIndex:0];
    }
}

#pragma mark - Get & Set

- (void)setBgImgV:(UIImageView *)bgImgV {
    // 存储新的
    objc_setAssociatedObject(self, @selector(bgImgV), bgImgV, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)bgImgV {
    // 获取存储
    return objc_getAssociatedObject(self, @selector(bgImgV));
}

#pragma mark - Public

/**
 设置导航栏颜色

 @param color 颜色值
 */
- (void)xr_setBarColor:(UIColor *)color {
    // 把原有的导航栏颜色设为透明
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
    // 设置新的导航栏颜色
    self.bgImgV.backgroundColor = color;
    [self sendSubviewToBack:self.bgImgV];
}

@end
