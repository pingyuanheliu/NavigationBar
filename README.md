### 第一步 引入分类文件
```
#import "UIImage+Color.h"
#import "UINavigationBar+handle.h"
#import "UINavigationController+handle.h"
#import "UIViewController+handle.h"
```

### 第二步 设置参数 

设置xr_useBarColor
该方法可以设置导航栏是否使用自定义效果。如果设置为YES，则使用自定义；如果设置为NO，则使用系统定义。
```
//是否使用子定义导航背景颜色
@property (nonatomic, assign) BOOL xr_useBarColor;
```

设置导航栏颜色
如果是用自定义导航栏效果，那么需要设置barTintColor。因为自定义的背景颜色是基于barTintColor来设定的。
```
@property(nullable, nonatomic,strong) UIColor *barTintColor;
```

设置xr_navBarHidden
该参数决定了导航栏隐藏/显示
```
//设置导航栏隐藏/显示
@property (nonatomic, assign) BOOL xr_navBarHidden;
```

设置xr_navBarAlpha
该参数决定了barTintColor的透明度，即影响导航栏透明度。
```
//设置导航栏透明度
@property (nonatomic, assign) CGFloat xr_navBarAlpha;
```

### 第三步 更新导航栏背景色
该方法非必须调用方法，只有当滚动scrollView时，动态更新导航栏颜色时，才会主动调用。
比如push/pop视图控制器时，默认会被调用。
```
/**
 更新导航栏
 
 @param barAlpha 导航栏透明度
 */
- (void)xr_updateNavigationBar:(CGFloat)barAlpha;
```

### pods集成方式
```
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'XRNavigationBar', '~> 0.0.1'
end
```
