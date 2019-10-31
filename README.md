### 第一步 引入导航栏分类
```
#import "UIImage+Color.h"
#import "UINavigationBar+handle.h"
#import "UINavigationController+handle.h"
```

  
设置useCustom
该方法可以设置导航栏是否使用自定义效果。如果设置为YES，则使用自定义；如果设置为NO，则使用系统定义。
```
//是否使用子定义导航背景
@property (nonatomic, assign) BOOL useCustom;
```

设置导航栏颜色
如果是用自定义导航栏效果，那么需要设置barTintColor。因为自定义的背景颜色是基于barTintColor来设定的。
```
@property(nullable, nonatomic,strong) UIColor *barTintColor;
```

  
### 第二步 引入视图控制器分类
```
#import "UIViewController+handle.h"
```

设置navBarAlpha
该参数决定了barTintColor的透明度，即影响导航栏透明度。
```
//设置导航栏透明度
@property (nonatomic, assign) CGFloat navBarAlpha;
```

### 第三步 更新导航栏背景色
```
//更新导航栏背景色
- (void)updateNavBar:(CGFloat)alpha;
```

### pods集成方式
```
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'XRNavigationBar', '~> 0.0.1'
end
```
