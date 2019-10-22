//
//  UINavigationController+handle.m
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UINavigationController+handle.h"
#import "UIViewController+handle.h"
#import "UINavigationBar+handle.h"
#import "UIImage+Color.h"
#import <objc/runtime.h>

@implementation UINavigationController (handle)

+ (void)initialize {
    if (self == [UINavigationController self]) {
        // 交换方法
        SEL originalSelector = NSSelectorFromString(@"_updateInteractiveTransition:");
        SEL swizzledSelector = NSSelectorFromString(@"cx_updateInteractiveTransition:");
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

// 交换的方法，监控滑动手势
- (void)cx_updateInteractiveTransition:(CGFloat)percentComplete {
    [self cx_updateInteractiveTransition:(percentComplete)];
    if (!self.useCustom) {
        return;
    }
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            // 随着滑动的过程设置导航栏透明度渐变
            UIViewController *fromVC = [coor viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIViewController *toVC = [coor viewControllerForKey:UITransitionContextToViewControllerKey];
            CGFloat toAlpha = toVC.navBarAlpha;
            CGFloat fromAlpha = fromVC.navBarAlpha;
            CGFloat curAlpha = fromAlpha + (toAlpha - fromAlpha)*percentComplete;
            UIColor *tint = topVC.navigationController.navigationBar.barTintColor;
            tint = [tint colorWithAlphaComponent:curAlpha];
            [self.navigationBar cx_setBackgroudColor:tint];
        }
    }
}

#pragma mark - Get & Set

- (BOOL)useCustom {
    id object = objc_getAssociatedObject(self, @selector(useCustom));
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object boolValue];
    }else {
        return NO;
    }
}

- (void)setUseCustom:(BOOL)useCustom {
    objc_setAssociatedObject(self, @selector(useCustom), [NSNumber numberWithBool:useCustom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (useCustom) {
        self.delegate = self;
    }else {
        self.delegate = nil;
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!self.useCustom) {
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
                    UIColor *tint = navigationController.navigationBar.barTintColor;
                    tint = [tint colorWithAlphaComponent:toVC.navBarAlpha];
                    [self.navigationBar cx_setBackgroudColor:tint];
                }];
            }
            //处理取消
            if (@available(iOS 10.0, *)) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    if ([context isCancelled]) {
                        UIColor *tint = navigationController.navigationBar.barTintColor;
                        tint = [tint colorWithAlphaComponent:fromVC.navBarAlpha];
                        [self.navigationBar cx_setBackgroudColor:tint];
                    }
                }];
            }else {
                [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    if ([context isCancelled]) {
                        UIColor *tint = navigationController.navigationBar.barTintColor;
                        tint = [tint colorWithAlphaComponent:toVC.navBarAlpha];
                        [self.navigationBar cx_setBackgroudColor:tint];
                    }
                }];
            }
        }
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!self.useCustom) {
        return;
    }
    UIColor *tint = navigationController.navigationBar.barTintColor;
    tint = [tint colorWithAlphaComponent:viewController.navBarAlpha];
    [self.navigationBar cx_setBackgroudColor:tint];
}

@end
