//
//  LoadingEffectView.m
//  UIViewLoadingEffect
//
//  Created by qq on 2017/7/22.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "LoadingEffectView.h"

@interface LoadingEffectView(){
}
@end

@implementation LoadingEffectView

-(instancetype)initWithFrame:(CGRect)frame{
    // 1. setup any properties here
    
    // 2. call super.init(frame:)
    self = [super initWithFrame: frame];
    
    // 3. Setup view from .xib file
    [self setup];
    
    return self;
}

-(void)setup{
    contentView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 320)];
    contentView.center= CGPointMake(self.center.x, self.center.y-100);
    self.backgroundColor = [UIColor colorWithRed:0xf5/255.0 green:0xf5/255.0 blue:0xf5/255.0 alpha:1];
    
    [self addSubview:contentView];
    
    imageView = [[UIImageView alloc]init];
    
    [contentView addSubview:imageView];
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 136, 220, 29)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0x87/255.0 green:0x87/255.0 blue:0x87/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:13];
    [contentView addSubview:label];
    
    button  = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:@"重新加载按钮"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [contentView addSubview:button];
    
    self.effect = LoadingEffectSuccess;
}

-(void)setEffect:(LoadingEffect)effect{
    
    NSString* networkStatus = [self getNetWorkStates];
    
    
    if([networkStatus isEqualToString: @"无网络"]){
        _effect = LoadingEffectNoNetwork;
    }else{
        _effect = effect;
    }
    switch(_effect){
        case LoadingEffectLoading:{
            NSArray* gifArray = [NSArray arrayWithObjects:
                        [UIImage imageNamed:@"正在加载1"],
                        [UIImage imageNamed:@"正在加载2"],
                        [UIImage imageNamed:@"正在加载3"],
                        [UIImage imageNamed:@"正在加载4"],
                        [UIImage imageNamed:@"正在加载5"],
                        [UIImage imageNamed:@"正在加载6"],
                        [UIImage imageNamed:@"正在加载7"],
                        [UIImage imageNamed:@"正在加载8"],
                        [UIImage imageNamed:@"正在加载9"],
                        [UIImage imageNamed:@"正在加载10"],
                        nil];
            imageView.frame = CGRectMake((220-185)/2, 0, 185, 185);
            imageView.animationImages = gifArray; //动画图片数组
            imageView.animationDuration = 0.75;
            imageView.animationRepeatCount = 0;  //动画重复次数，无限循环
            [imageView startAnimating];
            
            label.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame), 220, 29);
            label.text = @"正在加载，请稍候...";
            label.hidden = NO;
            
            button.hidden = YES;
            self.hidden = NO;
            break;
        }
        case LoadingEffectFailed:{
            
            [imageView stopAnimating];
            imageView.frame=CGRectMake(0, 0, 220, 175);
            imageView.image = [UIImage imageNamed:@"加载失败"];
            
            label.hidden = YES;
            
            button.hidden = NO;
            button.frame = CGRectMake(60, CGRectGetMaxY(imageView.frame), 100, 30);
            self.hidden = NO;
            
            break;
            
        }
        case LoadingEffectSuccess:{
            [imageView stopAnimating];
            self.hidden = YES;
            break;
        }
        case LoadingEffectNoNetwork:{
            [imageView stopAnimating];
            imageView.frame= CGRectMake(0, 0, 220, 175);
            imageView.image =[UIImage imageNamed:@"无网络"];
            
            label.hidden=YES;
            
            button.hidden = NO;
            button.frame = CGRectMake(60, CGRectGetMaxY(imageView.frame), 100, 30);
            self.hidden = NO;
            break;
        }
        
    }

}
-(void)buttonAction{
    if(_actionHandler){
        _actionHandler(self);
    }
}
- (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = @"无网络";
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state =  @"2G";
                    break;
                case 2:
                    state =  @"3G";
                    break;
                case 3:
                    state =   @"4G";
                    break;
                case 5:
                {
                    state =  @"wifi";
                    break;
                default:
                    break;
                }
            }
        }
        //根据状态选择
    }
    return state;
}
@end
