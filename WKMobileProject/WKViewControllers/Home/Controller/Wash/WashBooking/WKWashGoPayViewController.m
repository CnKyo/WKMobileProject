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

static float mDuration = 0.25;

@interface WKWashGoPayViewController ()<WKPayWashViewDelegate,WKWashPayResultViewDelegate>

@end

@implementation WKWashGoPayViewController
{
    
    WKPayWashView *mView;
    
    WKWashPayResultView *mSucessView;
    WKWashPayResultView *mErrorView;
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
    
    self.view.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    mView = [WKPayWashView initView];
    mView.delegate = self;
    mView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    [self.view addSubview:mView];
//    [mView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.view).offset(64);
//        make.right.left.bottom.equalTo(self.view);
//    }];

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
    mSucessView.delegate = self;
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
    [self showSucessView];
//    [self showErrorView];
}
- (void)WKPayWashViewDelegateCurrentPayType:(NSInteger)mType{
    
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
@end
