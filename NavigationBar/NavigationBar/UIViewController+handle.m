//
//  UIViewController+handle.m
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UIViewController+handle.h"
#import "UINavigationBar+handle.h"
#import "UIImage+Color.h"
#import <objc/runtime.h>

@implementation UIViewController (handle)

#pragma mark - Get & Set

- (CGFloat)navBarAlpha {
    return [objc_getAssociatedObject(self, @selector(navBarAlpha)) floatValue];
}

- (void)setNavBarAlpha:(CGFloat)navBarAlpha {
    objc_setAssociatedObject(self, @selector(navBarAlpha), [NSNumber numberWithFloat:navBarAlpha], OBJC_ASSOCIATION_ASSIGN);
    UIColor *color = [UIColor purpleColor];
    color = [color colorWithAlphaComponent:navBarAlpha];
    UIImage *image = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar cx_setBackgroudImage:image];
}

@end
