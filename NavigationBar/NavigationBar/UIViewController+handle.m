//
//  UIViewController+handle.m
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UIViewController+handle.h"

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

@end
