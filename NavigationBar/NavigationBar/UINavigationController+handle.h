//
//  UINavigationController+handle.h
//  NavigationBar
//
//  Created by LL on 2019/10/21.
//  Copyright © 2019 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (handle)<UINavigationControllerDelegate>

//是否使用子定义导航背景
@property (nonatomic, assign) BOOL useCustom;

@end
