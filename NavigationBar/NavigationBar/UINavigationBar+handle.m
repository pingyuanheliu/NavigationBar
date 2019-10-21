//
//  UINavigationBar+handle.m
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import "UINavigationBar+handle.h"
#import <objc/runtime.h>

@interface UINavigationBar ()

@property (strong, nonatomic) UIImageView *bgImgV;

@end

@implementation UINavigationBar (handle)

#pragma mark - Get & Set

- (void)setBgImgV:(UIImageView *)bgImgV {
    if (bgImgV != self.bgImgV) {
        // 删除旧的，添加新的
        [self.bgImgV removeFromSuperview];
        [self insertSubview:bgImgV atIndex:0];
    }
    // 存储新的
    objc_setAssociatedObject(self, @selector(bgImgV), bgImgV, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)bgImgV {
    return objc_getAssociatedObject(self, @selector(bgImgV));
}

#pragma mark - Public

- (void)cx_setBackgroudImage:(UIImage *)backgroundImage {
    if (self.bgImgV == nil) {
        CGRect rect = self.bounds;
        CGFloat margin;
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets insets = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
            margin = MAX(20.0, insets.top);
        }else {
            margin = 20.0;
        }
        rect.origin.y = -margin;
        rect.size.height += margin;
        NSLog(@"rect:%@",NSStringFromCGRect(rect));
        self.bgImgV = [[UIImageView alloc] initWithImage:backgroundImage];
        self.bgImgV.frame = rect;
    }else {
        [self.bgImgV setImage:backgroundImage];
    }
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

@end
