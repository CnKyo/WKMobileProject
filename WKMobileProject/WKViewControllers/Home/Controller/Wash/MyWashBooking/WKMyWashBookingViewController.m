//
//  WKMyWashBookingViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyWashBookingViewController.h"
#import "WKOperatorMyWashBookingView.h"
#import "WKScanDeviceViewController.h"
#import "MZTimerLabel.h"

@interface WKMyWashBookingViewController ()

@end

@implementation WKMyWashBookingViewController{
    WKOperatorMyWashBookingView *mView;
    MWMyWashOrderObj *mWashOrder;
    ///洗衣机状态。1:验证洗衣机。 2:开始洗衣。 3:正在洗衣。
    NSInteger mDeviceStatus;
    
    NSString *mDeviceCode;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarHairlineImageView.hidden = YES;
    
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的预约";
    mDeviceStatus = 1;
    mWashOrder = [MWMyWashOrderObj new];
    self.view.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    // Do any additional setup after loading the view.
    
    mView = [WKOperatorMyWashBookingView initview];
    mView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    [self.view addSubview:mView];
    [mView.mBtnAction addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self loadData];
}

- (void)loadData{
    if (mDeviceStatus == 1) {
        [SVProgressHUD showWithStatus:@"正在加载中..."];

        [MWBaseObj MWFindMyWashOrder:@{@"member_id":[WKUser currentUser].member_id} block:^(MWBaseObj *info,MWMyWashOrderObj *mWashOrderInfo) {
            if (info.err_code == 0) {
                [SVProgressHUD showSuccessWithStatus:info.err_msg];
                mWashOrder = mWashOrderInfo;
                [self updatePage];
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
                [self popViewController];
            }
            
        }];
    }else if(mDeviceStatus == 2){
        if (mDeviceCode.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"设备错误，请重新扫描！"];
            return;
        }
       [self updatePage];
    }else{
        
    }
    
}
- (void)updatePage{
    MLLog(@"%@",mWashOrder)

    if (mDeviceStatus == 2) {
        mView.mContent.text = @"验证成功，点击下方“开始洗衣”吧～";
        [mView.mBtnAction setTitle:@"开始洗衣" forState:0];
        MZTimerLabel *mC  = [[MZTimerLabel alloc] initWithLabel:mView.mCountTime andTimerType:MZTimerLabelTypeTimer];
        [mC resetTimerAfterFinish];
//        [mC reset];
        [mC setCountDownTime:15*60]; //** Or you can use [timer3 setCountDownToDate:aDate];
        [mC start];
        
    }else if(mDeviceStatus == 1){
        [mView.mBtnAction setTitle:@"验证机器" forState:0];
        MZTimerLabel *mC  = [[MZTimerLabel alloc] initWithLabel:mView.mCountTime andTimerType:MZTimerLabelTypeTimer];
        [mC resetTimerAfterFinish];

//        [mC reset];
        [mC setCountDownTime:15*60]; //** Or you can use [timer3 setCountDownToDate:aDate];
        [mC start];
    }else{
        [mView.mBtnAction setTitle:@"返回首页" forState:0];
        MZTimerLabel *mC  = [[MZTimerLabel alloc] initWithLabel:mView.mCountTime andTimerType:MZTimerLabelTypeTimer];
        [mC resetTimerAfterFinish];
        
        //        [mC reset];
        [mC setCountDownTime:15*60]; //** Or you can use [timer3 setCountDownToDate:aDate];
        [mC start];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mBtnAction:(UIButton *)sender{
    MLLog(@"按钮");
    if (mDeviceStatus == 2) {
        MLLog(@"开始洗衣");
        [SVProgressHUD showWithStatus:@"正在操作中..."];
        [MWBaseObj MWControlDevice:@{@"member_id":[WKUser currentUser].member_id,@"device_barcode":mDeviceCode} block:^(MWBaseObj *info) {
            if (info.err_code == 0) {
                [SVProgressHUD showSuccessWithStatus:info.err_msg];
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
                
            }
        }];
    }else if(mDeviceStatus == 1){
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WKScanDeviceViewController *vc = [board instantiateViewControllerWithIdentifier:@"scan"];;
        vc.mTyp = MWVeryfyDevice;
        vc.block = ^(NSInteger isOk,NSString *mCode){
            mDeviceCode = mCode;
            mDeviceStatus = isOk;
            
            [self loadData];
        };
        [self pushViewController:vc];
        
    }else{
        [self popViewController_2];
    }
   
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
