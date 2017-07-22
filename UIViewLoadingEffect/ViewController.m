//
//  ViewController.m
//  UIViewLoadingEffect
//
//  Created by qq on 2017/7/22.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "ViewController.h"
#import "LoadingEffectView.h"
#import "dimensions.h"

@interface ViewController (){
    LoadingEffectView* loadingView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    loadingView = [[LoadingEffectView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];//CGRectMake(0, 64, 300, 404);
    
    [self.view addSubview:loadingView];
    NSLog(@"%@",loadingView);
    loadingView.actionHandler = ^(LoadingEffectView* _loadingView){
        
        // 进行网络加载，这里用延迟几秒来模拟网络加载
        NSLog(@"重新加载...");
        LoadingEffect eff=_loadingView.effect;
        
        _loadingView.effect = LoadingEffectLoading;
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _loadingView.effect = eff;
        });
    };
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loadingAction:(id)sender {
    loadingView.effect = LoadingEffectLoading;
}
- (IBAction)loadingFailed:(id)sender {
    loadingView.effect = LoadingEffectFailed;
}
- (IBAction)loadingNoNetwork:(id)sender {
    loadingView.effect = LoadingEffectNoNetwork;
}
- (IBAction)loadingSuccess:(id)sender {
    loadingView.effect = LoadingEffectSuccess;
}

@end
