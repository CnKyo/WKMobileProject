//
//  WKHomeViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKHomeViewController.h"
#import "WKHeader.h"
#import "WKtrainDemandViewController.h"
@interface WKHomeViewController ()

@end

@implementation WKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";

    [self initView];
}
//- (NSString *)mSomething{
//   dispatch_queue_t WKSyncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    __block NSString *m;
//    dispatch_async(WKSyncQueue, ^{
//        m = _dosomething;
//        NSLog(@"----------%@",m);
//    });
//    return m;
//}
- (void)initView{
    UIButton *mBtn = [UIButton new];
    mBtn.backgroundColor = [UIColor redColor];
    [mBtn setTitle:@"火车票查询" forState:0];
    [mBtn addTarget:self action:@selector(mAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
    [mBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(90);
        make.height.offset(45);
    }];
}
- (void)mAction{
//    [self setDosomething3:@"调用了4？"];
//    
//    [self setDosomething1:@"调用了2？"];
//    
//    [self setDosomething:@"调用了1？"];
//
//    [self setDosomething2:@"调用了3？"];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        //加载图片
//        NSLog(@"one");
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            //加载完成更新view
//            NSLog(@"two");
//        });
//    });
    
    WKtrainDemandViewController *vc = [WKtrainDemandViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushViewController:vc];
}
- (void)setDosomething:(NSString *)dosomething{
    dispatch_queue_t WKSyncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_barrier_sync(WKSyncQueue, ^{
        _dosomething = dosomething;
        NSLog(@"----------执行1%@",_dosomething);
    });
}
- (void)setDosomething1:(NSString *)dosomething1{
    dispatch_queue_t WKSyncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_barrier_sync(WKSyncQueue, ^{
        _dosomething1 = dosomething1;
        NSLog(@"----------执行2%@",_dosomething1);
    });
}
- (void)setDosomething2:(NSString *)dosomething2{
    dispatch_queue_t WKSyncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_barrier_sync(WKSyncQueue, ^{
        _dosomething2 = dosomething2;
        NSLog(@"----------执行3%@",_dosomething2);
    });
}
- (void)setDosomething3:(NSString *)dosomething3{
    dispatch_queue_t WKSyncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_barrier_sync(WKSyncQueue, ^{
        _dosomething3 = dosomething3;
        NSLog(@"----------执行4%@",_dosomething3);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
