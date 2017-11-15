//
//  WKRecordViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKRecordViewController.h"
#import "WKRecordCell.h"
@interface WKRecordViewController ()<WKRecordCellDelegate>

@end

@implementation WKRecordViewController
{
    MWBundleToolObj *mAcountInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我要提现";
    mAcountInfo = [MWBundleToolObj new];
    [self addTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WKRecordCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    WKRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMUserInfo:[WKUser currentUser]];
    return cell;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 500;
    
    
}

/**
 提现金额代理方法
 
 @param mText 返回金额内容
 */
- (void)WKRecordCellWithRecordMoney:(NSString *)mText{
    MLLog(@"提现金额是：%@",mText);
    int mT = [mText intValue];
    int mU = [[WKUser currentUser].rewards intValue];
    if (mU<mT) {
        [SVProgressHUD showErrorWithStatus:@"账户余额不足！"];
        return;
    }
    mAcountInfo.mMoney = mText;
}

/**
 提现密码代理方法
 
 @param mText 返回密码输入内容
 */
- (void)WKRecordCellWithRecordPwd:(NSString *)mText{
    MLLog(@"提现密码是：%@",mText);
    mAcountInfo.mPwd = mText;
}

/**
 提现按钮代理方法
 */
- (void)WKRecordCellWithRecordBtnClicked{
    MLLog(@"提现");
    if (mAcountInfo.mMoney.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入提现金额！"];
        return;
    }
    if (mAcountInfo.mPwd.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入提现密码！"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在操作中..."];
    [MWBaseObj MWUserWithDraw:@{@"member_id":[WKUser currentUser].member_id,@"money":mAcountInfo.mMoney,@"password":mAcountInfo.mPwd} block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
    }];
}

@end
