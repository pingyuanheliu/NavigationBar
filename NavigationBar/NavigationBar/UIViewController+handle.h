//
//  UIViewController+handle.h
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (handle)

//设置导航栏透明度
@property (nonatomic, assign) CGFloat navBarAlpha;

+ (CGFloat)cx_navTopHeight;

//更新导航栏背景色
- (void)updateNavBar:(CGFloat)alpha;

@end
