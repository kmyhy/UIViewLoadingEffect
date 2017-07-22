# 自定义加载动效视图

自定义加载动效视图，提供四种不同的效果：加载中、加载失败、无网络、加载成功。

## 用法：

将 LoadingEffect.xcassets、LoadingEffectView.h/.m 添加到你的项目。

## 使用 LoadingEffectView

在 ViewController 中，添加 import 语句：

	#import "LoadingEffectView.h"

在 viewDidLoad 方法中，构造一个 LoadingEffectView 并添加到 subview 中:

	loadingView = [[LoadingEffectView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	[self.view addSubview:loadingView];
	
然后配置“重新加载”按钮的点击事件：

```swift
loadingView.actionHandler = ^(LoadingEffectView* _loadingView){
        
        // 进行网络加载，这里用延迟几秒来模拟网络加载
        NSLog(@"重新加载...");
        LoadingEffect eff=_loadingView.effect;
        
        _loadingView.effect = LoadingEffectLoading;
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _loadingView.effect = eff;
        });
    };
```

设置动效类型 ：

	loadingView.effect = LoadingEffectLoading;
	
effect 属性是一个 LoadingEffect 枚举，提供四种不同的效果：加载中、加载失败、无网络、加载成功：

```swift
typedef NS_ENUM(NSUInteger,LoadingEffect){
    LoadingEffectLoading,   // 正在加载动效
    LoadingEffectNoNetwork, // 无网络
    LoadingEffectSuccess,   // 加载成功
    LoadingEffectFailed     // 加载失败
};
```

> 注意，无网络是自动设置的，每次修改 effect 属性时，都会判断网络状况，如果发现断网，自动设置为“无网络”效果

具体每种动效效果，请运行 demo 项目。

