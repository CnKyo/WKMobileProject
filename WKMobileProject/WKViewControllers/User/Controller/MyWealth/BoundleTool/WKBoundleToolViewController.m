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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"绑定收款工具";
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
    return 600;
    
    
}

/**
 选择提现账户类型
 
 @param mType 1微信支付，2支付宝支付
 */
- (void)WKBoundleToolCellDelegateDidSelectedType:(NSInteger)mType{
    MLLog(@"type:%ld",mType);
}

/**
 支付密码
 
 @param mTag 密码输入框tag。1是密码，2是确认密码
 @param mText 返回输入框内容
 */
- (void)WKBoundleToolCellDelegateWithTag:(NSInteger)mTag WithPwdText:(NSString *)mText{
    MLLog(@"tag:%ld ----- 内容是:%@",mTag,mText);

}

/**
 确认提交按钮
 */
- (void)WKBoundleToolCellDelegateWithCommitAction{
    MLLog(@"确认提交");
}
@end
