//
//  UIViewController+handle.h
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (handle)

@property (nonatomic, assign) CGFloat navBarAlpha;

- (void)updateNavBar:(CGFloat)alpha;

+ (CGFloat)cx_navTopHeight;

@end
