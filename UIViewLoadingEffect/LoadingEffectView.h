//
//  LoadingEffectView.h
//  UIViewLoadingEffect
//
//  Created by qq on 2017/7/22.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LoadingEffect){
    LoadingEffectLoading,   // 正在加载动效
    LoadingEffectNoNetwork, // 无网络
    LoadingEffectSuccess,   // 加载成功
    LoadingEffectFailed     // 加载失败
};

@interface LoadingEffectView : UIView{
    UIView* contentView;
    UIImageView* imageView;
    UILabel* label;
    UIButton* button;
}

@property(assign,nonatomic)LoadingEffect effect;
@property(copy,nonatomic)void(^actionHandler)(LoadingEffectView* loadingView);
@end
