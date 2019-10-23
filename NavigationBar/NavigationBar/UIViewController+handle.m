//
//  UIViewController+handle.m
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UIViewController+handle.h"
#import "UINavigationBar+handle.h"
#import "UINavigationController+handle.h"
#import "UIImage+Color.h"
#import <objc/runtime.h>

@implementation UIViewController (handle)

#pragma mark - Top Height

+ (CGFloat)cx_navTopHeight {
    CGFloat margin;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[UIApplication sharedApplication] delegate].window;
        UIEdgeInsets insets = window.safeAreaInsets;
        margin = MAX(20.0, insets.top);
    }else {
        margin = 20.0;
    }
    return margin;
}

#pragma mark - Get & Set

- (CGFloat)navBarAlpha {
    id object = objc_getAssociatedObject(self, @selector(navBarAlpha));
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object floatValue];
    }else {
        return 1.0;
    }
}

- (void)setNavBarAlpha:(CGFloat)navBarAlpha {
    objc_setAssociatedObject(self, @selector(navBarAlpha), [NSNumber numberWithFloat:navBarAlpha], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Update

- (void)updateNavBar:(CGFloat)alpha {
    UIColor *tint = self.navigationController.navigationBar.barTintColor;
    tint = [tint colorWithAlphaComponent:alpha];
    self.navigationController.delegate = self.navigationController;
    [self.navigationController.navigationBar cx_setBackgroudColor:tint];
}

@end
