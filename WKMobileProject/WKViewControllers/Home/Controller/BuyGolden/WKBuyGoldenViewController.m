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
    self.mGoldObj = [MWBuyGold new];
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
    return 650;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKBuyGoldCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.mGoldObj.mNum.length<=0 || [self.mGoldObj.mNum isEqualToString:@""]) {
        self.mGoldObj.mNum = @"0";
    }
    
    NSDictionary* style1 = @{@"color": [UIColor colorWithRed:0.97 green:0.58 blue:0.27 alpha:1]};
    cell.mPayPrice.attributedText = [[NSString stringWithFormat:@"应支付金额：<color>¥%@元</color>",self.mGoldObj.mNum] attributedStringWithStyleBook:style1];
    
    cell.mExplain.text = @"金币使用说明：\n 1：付款前务必和好友再次确认，避免是欺诈行为。\n 2:如果发生退款，钱将退还到您的微信账号。";
    
    cell.delegate = self;
    
    return cell;
    
}
/**
 选择支付方式代理方法
 
 @param mType 返回当前选择的支付方式（1是微信支付，2是支付宝支付,3是银联支付,0是未选择）
 */
- (void)WKBuyGoldCellDelegateWithPayType:(NSInteger)mType{
    MLLog(@"选择了：%ld",mType);
    self.mGoldObj.mPayType = mType;
    
}
/**
 选择直接支付还是微信好友支付
 
 @param mTag 返回当前选择的支付方式（1是直接支付，2是微信好友支付）
 */
- (void)WKBuyGoldCellDelegateIsGoPayOrFriendPayBtnClicked:(NSInteger)mTag{
    MLLog(@"选择了：%ld",mTag);
//    [self showSucessView];
    if (self.mGoldObj.mNum <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入购买金额！"];
        return;
    }
    if (self.mGoldObj.mPayType <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择支付方式！"];
        return;
    }
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.mGoldObj.mNum forKey:@"number"];
    [para setObject:[WKUser currentUser].member_id forKey:@"member_id"];
//    [para setObject:[NSString stringWithFormat:@"%d",self.mGoldObj.mPayType] forKey:@"number"];
    [MWBaseObj MWBuyGold:para amdPayType:self.mGoldObj.mPayType block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
    }];


}
/**
 输入框代理方法
 
 @param mText 返回输入文本内容
 */
- (void)WKBuyGoldCellDelegateCurrentTextField:(NSString *)mText{
    MLLog(@"输入了：%@",mText);
 
    self.mGoldObj.mNum = mText;
    [self.tableView reloadData];
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
