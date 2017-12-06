//
//  WKWashGoPayViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashGoPayViewController.h"
#import "WKPayWashView.h"
#import "WKWashPayResultView.h"
#import "TimeModel.h"

#import "MZTimerLabel.h"
static float mDuration = 0.25;

@interface WKWashGoPayViewController ()<WKPayWashViewDelegate,WKWashPayResultViewDelegate>

@end

@implementation WKWashGoPayViewController
{
    
    WKPayWashView *mView;
    
    WKWashPayResultView *mSucessView;
    WKWashPayResultView *mErrorView;
    
    NSInteger mPayType;
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
    self.navigationItem.title = @"去支付";
    mPayType = 0;
    self.view.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    mView = [WKPayWashView initView];
    mView.delegate = self;
    
    NSDictionary* style1 = @{@"color": [UIColor colorWithRed:0.97 green:0.58 blue:0.27 alpha:1]};
    mView.mDetailTx.attributedText = [[NSString stringWithFormat:@"%@ | %@ | <color> %@元</color>",self.mOrderInfo.location_name,self.mOrderInfo.wash_feature_name,self.mOrderInfo.order_price] attributedStringWithStyleBook:style1];
    //    mView.mCountTimeTx.hidden = YES;
    
    mView.mPayPriceTx.attributedText = [[NSString stringWithFormat:@"应付款金额：<color> %@元</color>",self.mOrderInfo.order_price] attributedStringWithStyleBook:style1];
    
    //    TimeModel *model = [TimeModel new];
    //    model.endTime = [Util WKCurrentTimePlusTo15Min:120];
    //    mView.mCountTimeTx.text = [self.countDown countDownWithModel:model timeLabel:mView.mCountTimeTx];
    
    MZTimerLabel *mC  = [[MZTimerLabel alloc] initWithLabel:mView.mCountTimeTx andTimerType:MZTimerLabelTypeTimer];
    [mC setCountDownTime:15*60]; //** Or you can use [timer3 setCountDownToDate:aDate];
    [mC start];
    mView.frame = CGRectMake(0, 104, DEVICE_Width, DEVICE_Height-64);
    [self.view addSubview:mView];
    
    
    [self initSucessView];
    [self initErrorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----****----初始化支付成功和失败view
- (void)initSucessView{
    mSucessView = [WKWashPayResultView initSucessView];
    mSucessView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height
                                   );
    mSucessView.mDetail.text = [NSString stringWithFormat:@"此次付款%@元",self.mOrderInfo.order_price];
    mSucessView.delegate = self;
    
    MZTimerLabel *mC  = [[MZTimerLabel alloc] initWithLabel:mSucessView.mCountTime andTimerType:MZTimerLabelTypeTimer];
    [mC setCountDownTime:15*60]; //** Or you can use [timer3 setCountDownToDate:aDate];
    [mC start];
    
    [self.view addSubview:mSucessView];
}
- (void)initErrorView{
    mErrorView = [WKWashPayResultView initErrorView];
    mErrorView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height
                                  );
    mErrorView.delegate = self;
    [self.view addSubview:mErrorView];
}
- (void)updatePopView{
    
}
- (void)showSucessView{
    [UIView animateWithDuration:mDuration animations:^{
        CGRect mSuceessF = mSucessView.frame;
        mSuceessF.origin.y = 0;
        mSucessView.frame = mSuceessF;
    }];
    
}
- (void)showErrorView{
    [UIView animateWithDuration:mDuration animations:^{
        CGRect mErrorF = mErrorView.frame;
        mErrorF.origin.y = 64;
        mErrorView.frame = mErrorF;
    }];
}

- (void)hiddeSucessView{
    [UIView animateWithDuration:mDuration animations:^{
        CGRect mSuceessF = mSucessView.frame;
        mSuceessF.origin.y = DEVICE_Height;
        mSucessView.frame = mSuceessF;
    }];
}
- (void)hiddeErrorView{
    [UIView animateWithDuration:mDuration animations:^{
        CGRect mErrorF = mErrorView.frame;
        mErrorF.origin.y = DEVICE_Height;
        mErrorView.frame = mErrorF;
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark----****----去支付按钮代理方法
- (void)WKPayWashViewDelegateWithPayBtnClicked{
    MLLog(@"去支付");
    //    [self showSucessView];
    //    [self showErrorView];
    NSString *mPay = @"";
    if (mPayType == 1) {
        mPay = @"wx_pay";
    }else if (mPayType == 2){
        
        mPay = @"zfb_pay";
        
    }else if (mPayType == 3){
        
        mPay = @"jb_pay";
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择支付方式！"];
        return;
        
    }
    [SVProgressHUD showWithStatus:@"正在支付..."];
    
    [MWBaseObj MWGoPayWashOrder:@{@"member_id":[WKUser currentUser].member_id,@"order_no":_mOrderInfo.order_no,@"pay_name":mPay} andPayType:mPayType block:^(MWBaseObj *info, MWWashOrderObj *mOrderObj) {
        if (info.err_code == 0) {
            [self showSucessView];
        }else{
            [self showErrorView];
            [SVProgressHUD showErrorWithStatus:info.err_msg];
            
        }
        [SVProgressHUD dismiss];
    }];
    
    
}
- (void)WKPayWashViewDelegateCurrentPayType:(NSInteger)mType{
    mPayType = mType;
    switch (mType) {
        case 0:
        {
        MLLog(@"无");
        
        }
            break;
        case 1:
        {
        MLLog(@"微信");
        }
            break;
        case 2:
        {
        MLLog(@"支付宝");
        }
            break;
        case 3:
        {
        MLLog(@"金币");
        }
            break;
        case 4:
        {
        MLLog(@"银联");
        }
            break;
            
        default:
            break;
    }
}

- (void)WKWashPayResultViewWithBackAction{
    [self hiddeSucessView];
    [self hiddeErrorView];
}
- (void)mBackAction{
    [self WKWashPayResultViewWithBackAction];
    
    [self popViewController];
    
}
//- (ZJJTimeCountDown *)countDown{
//
//    if (!_countDown) {
//        _countDown = [[ZJJTimeCountDown alloc] initWithScrollView:self.tableView dataList:self.tableArr];
//        _countDown.delegate = self;
//    }
//    return _countDown;
//}
//- (void)dealloc {
//    /// 2.销毁
//    [_countDown destoryTimer];
//}
@end
