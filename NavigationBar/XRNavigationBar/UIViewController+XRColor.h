//
//  UIViewController+XRColor.h
//  XRNavigationBar
//
//  Created by LL on 2019/10/28.
//  Copyright © 2019 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XRColor)

//设置导航栏透明度
@property (nonatomic, assign) CGFloat xr_navBarAlpha;

/**
 更新导航栏
 
 @param barAlpha 导航栏透明度
 */
- (void)xr_updateNavigationBar:(CGFloat)barAlpha;

@end

NS_ASSUME_NONNULL_END
