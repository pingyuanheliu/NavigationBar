//
//  UINavigationController+XR.m
//  XRNavigationBar
//
//  Created by LL on 2019/10/28.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UINavigationController+XR.h"
#import "UIViewController+XRColor.h"
#import "UINavigationBar+XRColor.h"
#import <objc/runtime.h>

@implementation UINavigationController (XR)

+ (void)initialize {
    if (self == [UINavigationController self]) {
        // 交换方法
        SEL originalSelector = NSSelectorFromString(@"_updateInteractiveTransition:");
        SEL swizzledSelector = NSSelectorFromString(@"xr_updateInteractiveTransition:");
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

// 交换的方法，监控滑动手势
- (void)xr_updateInteractiveTransition:(CGFloat)percentComplete {
    [self xr_updateInteractiveTransition:(percentComplete)];
    if (!self.xr_useBarColor) {
        return;
    }
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            // 随着滑动的过程设置导航栏透明度渐变
            UIViewController *fromVC = [coor viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIViewController *toVC = [coor viewControllerForKey:UITransitionContextToViewControllerKey];
            CGFloat toAlpha = toVC.xr_navBarAlpha;
            CGFloat fromAlpha = fromVC.xr_navBarAlpha;
            CGFloat curAlpha = fromAlpha + (toAlpha - fromAlpha)*percentComplete;
            // 更新导航栏
            [self xr_setBarAlpha:curAlpha navigationController:topVC.navigationController];
        }
    }
}

#pragma mark - Get & Set

- (BOOL)xr_useBarColor {
    id object = objc_getAssociatedObject(self, @selector(xr_useBarColor));
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object boolValue];
    }else {
        return NO;
    }
}

- (void)setXr_useBarColor:(BOOL)xr_useBarColor {
    NSNumber *use = [NSNumber numberWithBool:xr_useBarColor];
    objc_setAssociatedObject(self, @selector(xr_useBarColor), use, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (xr_useBarColor) {
        self.delegate = self;
    }else {
        self.delegate = nil;
    }
}

#pragma mark - Private Method

- (void)xr_setBarAlpha:(CGFloat)alpha navigationController:(UINavigationController *)navigationController {
    UIColor *tint = navigationController.navigationBar.barTintColor;
    tint = [tint colorWithAlphaComponent:alpha];
    [self.navigationBar xr_setBarColor:tint];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!self.xr_useBarColor) {
        return;
    }
    UIViewController *topVC = self.topViewController;
    
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            UIViewController *fromVC = [coor viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIViewController *toVC = [coor viewControllerForKey:UITransitionContextToViewControllerKey];
            //非手势交互(点击按钮)
            if (!coor.isInteractive) {
                [UIView animateWithDuration:coor.transitionDuration animations:^{
                    // 更新导航栏
                    [self xr_setBarAlpha:toVC.xr_navBarAlpha navigationController:navigationController];
                }];
            }
            //处理取消
            if (@available(iOS 10.0, *)) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    if ([context isCancelled]) {
                        // 更新导航栏
                        [self xr_setBarAlpha:fromVC.xr_navBarAlpha navigationController:navigationController];
                    }
                }];
            }else {
                [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    if ([context isCancelled]) {
                        // 更新导航栏
                        [self xr_setBarAlpha:toVC.xr_navBarAlpha navigationController:navigationController];
                    }
                }];
            }
        }
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!self.xr_useBarColor) {
        return;
    }
    // 更新导航栏
    [self xr_setBarAlpha:viewController.xr_navBarAlpha navigationController:navigationController];
}

@end
