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

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self == [UIViewController self]) {
            // 交换Transition
            [UIViewController xr_exchangeViewDidLoad];
        }
    });
}

#pragma mark - Private Swizzle

+ (void)xr_exchangeViewDidLoad {
    // 交换方法
    SEL originalSelector = @selector(viewDidLoad);
    SEL swizzledSelector = @selector(xr_viewDidLoad);
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

#pragma mark - Swizzled method

- (void)xr_viewDidLoad {
    [self xr_viewDidLoad];
    [self xr_updateNavigationBar:self.xr_navBarAlpha];
    [self.navigationController setNavigationBarHidden:self.xr_navBarHidden animated:NO];
}

#pragma mark - Get & Set

- (BOOL)xr_navBarHidden {
    id object = objc_getAssociatedObject(self, @selector(xr_navBarHidden));
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object boolValue];
    }else {
        // 默认不隐藏
        return NO;
    }
}

- (void)setXr_navBarHidden:(BOOL)xr_navBarHidden {
    NSNumber *hidden = [NSNumber numberWithBool:xr_navBarHidden];
    objc_setAssociatedObject(self, @selector(xr_navBarHidden), hidden, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -

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
