//
//  UIViewController+XRColor.m
//  XRNavigationBar
//
//  Created by LL on 2019/10/28.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UIViewController+XRColor.h"
#import "UINavigationBar+XRColor.h"
#import "UINavigationController+XR.h"
#import <objc/runtime.h>

@implementation UIViewController (XRColor)

#pragma mark - Get & Set

- (CGFloat)xr_navBarAlpha {
    id object = objc_getAssociatedObject(self, @selector(xr_navBarAlpha));
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object floatValue];
    }else {
        // 默认不透明
        return 1.0;
    }
}

- (void)setXr_navBarAlpha:(CGFloat)xr_navBarAlpha {
    NSNumber *alpha = [NSNumber numberWithFloat:xr_navBarAlpha];
    objc_setAssociatedObject(self, @selector(xr_navBarAlpha), alpha, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -
/**
 更新导航栏

 @param barAlpha 导航栏透明度
 */
- (void)xr_updateNavigationBar:(CGFloat)barAlpha {
    self.navigationController.delegate = self.navigationController;
    UIColor *tint = self.navigationController.navigationBar.barTintColor;
    tint = [tint colorWithAlphaComponent:barAlpha];
    [self.navigationController.navigationBar xr_setBarColor:tint];
}

@end
