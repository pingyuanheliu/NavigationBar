//
//  UINavigationBar+handle.m
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UINavigationBar+handle.h"
#import <objc/runtime.h>

@implementation UINavigationBar (handle)


+ (void)initialize {
    if (self == [UINavigationBar class]) {
        NSLog(@"==handle==");
        // 交换方法
         SEL originalSelector = @selector(didMoveToWindow);
        SEL swizzledSelector = @selector(et_didMoveToWindow);
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        if (class_addMethod([self class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(originalMethod))) {
            class_replaceMethod([self class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

- (void)et_didMoveToWindow
{
    [self et_didMoveToWindow];
    NSLog(@"et_didMoveToWindow:%@=%@",NSStringFromCGRect(self.frame),self.subviews);
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
        NSLog(@"rect1:%@",NSStringFromCGRect(rect));
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
    return objc_getAssociatedObject(self, @selector(bgImgV));
}

#pragma mark - Public

- (void)cx_setBackgroudColor:(UIColor *)color {
    NSLog(@"cx_setBackgroudColor:%@==%@",NSStringFromCGRect(self.frame),self.subviews);
    self.bgImgV.backgroundColor = color;
    [self sendSubviewToBack:self.bgImgV];
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
}

@end
