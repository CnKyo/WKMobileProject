//
//  WKBuyGoldenViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBuyGoldenViewController.h"
#import "WKBuyGoldCell.h"
#import "WKWashPayResultView.h"

static float mDuration = 0.25;

@interface WKBuyGoldenViewController ()<WKBuyGoldCellDelegate,WKWashPayResultViewDelegate>

@end

@implementation WKBuyGoldenViewController
{
    WKWashPayResultView *mSucessView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"确认订单";
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKBuyGoldCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self initSucessView];

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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKBuyGoldCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    
    return cell;
    
}
/**
 选择支付方式代理方法
 
 @param mType 返回当前选择的支付方式（1是微信支付，2是支付宝支付,0是未选择）
 */
- (void)WKBuyGoldCellDelegateWithPayType:(NSInteger)mType{
    MLLog(@"选择了：%ld",mType);
}
/**
 选择直接支付还是微信好友支付
 
 @param mTag 返回当前选择的支付方式（1是直接支付，2是微信好友支付）
 */
- (void)WKBuyGoldCellDelegateIsGoPayOrFriendPayBtnClicked:(NSInteger)mTag{
    MLLog(@"选择了：%ld",mTag);
    [self showSucessView];
}
/**
 输入框代理方法
 
 @param mText 返回输入文本内容
 */
- (void)WKBuyGoldCellDelegateCurrentTextField:(NSString *)mText{
    MLLog(@"输入了：%@",mText);

}
#pragma mark----****----初始化支付成功和失败view
- (void)initSucessView{
    mSucessView = [WKWashPayResultView initVIPSucessView];
    mSucessView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height
                                   );
    mSucessView.delegate = self;
    mSucessView.mTopupMessageContent.hidden = YES;
    [self.view addSubview:mSucessView];
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
- (void)hiddeSucessView{
    [UIView animateWithDuration:mDuration animations:^{
        CGRect mSuceessF = mSucessView.frame;
        mSuceessF.origin.y = DEVICE_Height;
        mSucessView.frame = mSuceessF;
    }];
}
///按钮代理方法
- (void)WKWashPayResultViewWithBackAction{
    MLLog(@"错误信息按钮");
    [self hiddeSucessView];
}
- (void)mBackAction{
    [self WKWashPayResultViewWithBackAction];
    
    [self popViewController];
    
}

@end
