//
//  WKMyMoneyViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyMoneyViewController.h"
#import "WKHeader.h"
#import "WKMyPayListCell.h"
#import "WKWithDrawViewController.h"
#import "WKBundleBankCardViewController.h"
@interface WKMyMoneyViewController ()

@end

@implementation WKMyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMTitle:@"我的余额"];
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKMyPayListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    [self setMHiddenRightBtn:NO];

}
- (void)rightBtnAction{
    
    MLLog(@"添加银行卡");
    WKBundleBankCardViewController *vc = [WKBundleBankCardViewController new];
    //        [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
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
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 10;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    CellId = @"cell1";
    
    WKMyPayListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *mBgk = [UIView new];
    mBgk.frame = CGRectMake(0, 0, DEVICE_Width, 100);
    mBgk.backgroundColor = [UIColor whiteColor];
    
    UILabel *mMoney = [UILabel new];
    mMoney.text = @"4555元";
    mMoney.textColor = [UIColor redColor];
    mMoney.frame = mBgk.bounds;
    mMoney.textAlignment = NSTextAlignmentCenter;
    mMoney.font = [UIFont systemFontOfSize:45];
    [mBgk addSubview:mMoney];
    
    UIView *mLine = [UIView new];
    mLine.frame = CGRectMake(0, 90, DEVICE_Width, 10);
    mLine.backgroundColor = [UIColor orangeColor];
    [mBgk addSubview:mLine];

    return mBgk;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *mBgk = [UIView new];
    mBgk.frame = CGRectMake(0, 0, DEVICE_Width, 45);
    mBgk.backgroundColor = [UIColor whiteColor];
    
    UIButton *mBtn = [UIButton new];
    [mBtn setTintColor:[UIColor whiteColor]];
    mBtn.backgroundColor = [UIColor redColor];
    [mBtn setFrame:mBgk.bounds];
    [mBtn setTitle:@"提现" forState:0];
    [mBtn addTarget:self action:@selector(mWithDraw) forControlEvents:UIControlEventTouchUpInside];
    [mBgk addSubview:mBtn];

    
    return mBgk;
    
}
- (void)mWithDraw{
    
    MLLog(@"提现");
    WKWithDrawViewController *vc = [WKWithDrawViewController new];
    //        [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 45;
}
@end
