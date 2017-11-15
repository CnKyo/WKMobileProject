//
//  WKBoundleToolViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBoundleToolViewController.h"
#import "WKBoundleToolCell.h"
@interface WKBoundleToolViewController ()<WKBoundleToolCellDelegate>

@end

@implementation WKBoundleToolViewController
{
    MWBundleToolObj *mTool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"绑定收款工具";
    mTool = [MWBundleToolObj new];
    [self addTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"WKBoundleToolCell" bundle:nil] forCellReuseIdentifier:@"cell"];

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKBoundleToolCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 700;
    
    
}

/**
 选择提现账户类型
 
 @param mType 1微信支付，2支付宝支付
 */
- (void)WKBoundleToolCellDelegateDidSelectedType:(NSInteger)mType{
    MLLog(@"type:%ld",mType);
    mTool.mPayType = [NSString stringWithFormat:@"%ld",mType];
}

/**
 支付密码
 
 @param mTag 密码输入框tag。1是密码，2是确认密码  3是提现账户
 @param mText 返回输入框内容
 */
- (void)WKBoundleToolCellDelegateWithTag:(NSInteger)mTag WithPwdText:(NSString *)mText{
    MLLog(@"tag:%ld ----- 内容是:%@",mTag,mText);
    switch (mTag) {
        case 3:
        {
        mTool.mAcount = mText;

        }
            break;
        case 2:
        {
        mTool.mCPwd = mText;
        
        }
            break;
        case 1:
        {
        mTool.mPwd = mText;
        
        }
            break;
            
        default:
            break;
    }

}

/**
 确认提交按钮
 */
- (void)WKBoundleToolCellDelegateWithCommitAction{
    MLLog(@"确认提交");
    if (mTool.mPayType.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择提现账户类型！"];
        return;
    }
    if (mTool.mAcount.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请设置提现账户！"];
        return;
    }
    if (mTool.mPwd.length==0) {
        [SVProgressHUD showErrorWithStatus:@"您还未设置提现密码！"];
        return;
    }
    if (mTool.mCPwd.length==0) {
        [SVProgressHUD showErrorWithStatus:@"您还未设置提现确认密码！"];
        return;
    }
    if (![mTool.mPwd isEqualToString:mTool.mCPwd]) {
        [SVProgressHUD showErrorWithStatus:@"2次提现密码输入不一致！"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在设置..."];
    [MWBaseObj MWBundleTool:@{@"member_id":[WKUser currentUser].member_id,@"pay_type":mTool.mPayType,@"paypassword":mTool.mPwd,@"pay_number":mTool.mAcount} block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
    }];
    
}
@end
