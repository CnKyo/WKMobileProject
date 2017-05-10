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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    self.d_navBarAlpha = 0;
    
    [self initView];
}
- (void)initView{
    UIButton *mBtn = [UIButton new];
    mBtn.frame = CGRectMake(10, 90, DEVICE_Width-20, 45);

    mBtn.backgroundColor = [UIColor redColor];
    [mBtn setTitle:@"火车票查询" forState:0];
    [mBtn addTarget:self action:@selector(mAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
    [mBtn setButtonRoundedCornersWithView:self.view andCorners:UIRectCornerAllCorners radius:3.0];

}
- (void)mAction{

    [self showCustomViewType:WKCustomPopViewHaveCloseBtn andTitle:@"这个是标题" andContentTx:@"这个是内容内容内容" andOkBtntitle:@"确定" andCancelBtntitle:@"取消"];

    
    
//    WKtrainDemandViewController *vc = [WKtrainDemandViewController new];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        //加载图片
//        NSLog(@"one");
//        [self.navigationController.navigationBar setHidden:NO];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            //加载完成更新view
//            NSLog(@"two");
//            [self.navigationController d_pushViewController:vc fromAlpha:self.d_navBarAlpha toAlpha:1];
//
//        });
//    });
    
}
- (void)WKCustomPopViewWithCloseBtnAction{
    
    NSLog(@"取消");
}
- (void)WKCustomPopViewWithOkBtnAction{
    
    
    NSLog(@"好的");
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
