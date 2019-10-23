### 第一步 引入导航栏分类
```
#import "UIImage+Color.h"
#import "UINavigationBar+handle.h"
#import "UINavigationController+handle.h"
```

  
设置useCustom
```
//是否使用子定义导航背景
@property (nonatomic, assign) BOOL useCustom;
```

设置导航栏颜色
```
@property(nullable, nonatomic,strong) UIColor *barTintColor;
```

  
### 第二步 引入视图控制器分类
```
#import "UIViewController+handle.h"
```

设置navBarAlpha
```
//设置导航栏透明度
@property (nonatomic, assign) CGFloat navBarAlpha;
```

### 第三步 更新导航栏背景色
```
//更新导航栏背景色
- (void)updateNavBar:(CGFloat)alpha;
```
