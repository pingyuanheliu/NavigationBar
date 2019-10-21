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
        SEL swizzledSelector = NSSelectorFromString(@"et__updateInteractiveTransition:");
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
        //
        SEL originalSelector1 = NSSelectorFromString(@"_cancelInteractiveTransition");
        SEL swizzledSelector1 = NSSelectorFromString(@"et__cancelInteractiveTransition");
        Method originalMethod1 = class_getInstanceMethod([self class], originalSelector1);
        Method swizzledMethod1 = class_getInstanceMethod([self class], swizzledSelector1);
        method_exchangeImplementations(originalMethod1, swizzledMethod1);
        //
        SEL originalSelector2 = NSSelectorFromString(@"_finishInteractiveTransition");
        SEL swizzledSelector2 = NSSelectorFromString(@"et__finishInteractiveTransition");
        Method originalMethod2 = class_getInstanceMethod([self class], originalSelector2);
        Method swizzledMethod2 = class_getInstanceMethod([self class], swizzledSelector2);
        method_exchangeImplementations(originalMethod2, swizzledMethod2);
    }
}

- (void)et__cancelInteractiveTransition {
    [self et__cancelInteractiveTransition];
    NSLog(@"et__cancelInteractiveTransition");
}

- (void)et__finishInteractiveTransition {
    [self et__finishInteractiveTransition];
    NSLog(@"et__finishInteractiveTransition");
}

// 交换的方法，监控滑动手势
- (void)et__updateInteractiveTransition:(CGFloat)percentComplete {
    [self et__updateInteractiveTransition:(percentComplete)];
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            // 随着滑动的过程设置导航栏透明度渐变
            UIViewController *fromVC = [coor viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIViewController *toVC = [coor viewControllerForKey:UITransitionContextToViewControllerKey];
            CGFloat nowAlpha = fabs(toVC.navBarAlpha - fromVC.navBarAlpha) * percentComplete;
            NSLog(@"from:%@, to:%@ ==percent:%f==alpha:%f",fromVC, toVC, percentComplete,nowAlpha);
            UIColor *color = [UIColor purpleColor];
            color = [color colorWithAlphaComponent:nowAlpha];
            UIImage *image = [UIImage imageWithColor:color];
            [self.navigationBar cx_setBackgroudImage:image];
        }
    }
}

#pragma mark - UINavigationBarDelegate

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
    NSLog(@"push:%@",self.viewControllers);
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    NSLog(@"pop:%@",self.viewControllers);
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"willShowViewController:%@",viewController);
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            NSLog(@"animation:%@==transitionDuration:%@==interactive:%@==percentComplete:%@",@(coor.isAnimated),@(coor.transitionDuration),@(coor.isInteractive),@(coor.percentComplete));
            UIViewController *fromVC = [coor viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIViewController *toVC = [coor viewControllerForKey:UITransitionContextToViewControllerKey];
            NSLog(@"fromVC:%@",fromVC);
            NSLog(@"toVC:%@",toVC);
            if (@available(iOS 10.0, *)) {
                
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    if ([context isCancelled]) {
                        NSLog(@"==1==:%@",fromVC);
                        UIColor *color = [UIColor purpleColor];
                        color = [color colorWithAlphaComponent:fromVC.navBarAlpha];
                        UIImage *image = [UIImage imageWithColor:color];
                        [self.navigationBar cx_setBackgroudImage:image];
                    }else {
                        NSLog(@"==2==");
                    }
                }];
            }
        }
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"didShowViewController:%@",viewController);
    UIColor *color = [UIColor purpleColor];
    color = [color colorWithAlphaComponent:viewController.navBarAlpha];
    UIImage *image = [UIImage imageWithColor:color];
    [self.navigationBar cx_setBackgroudImage:image];
}

@end
