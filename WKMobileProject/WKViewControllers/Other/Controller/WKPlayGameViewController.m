//
//  WKPlayGameViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//
#import "WKHeader.h"
#import "WKPlayGameViewController.h"
#import "WKPlayGameCell.h"
#import "UIScrollView+DREmptyDataSet.h"
#import "UIScrollView+DRRefresh.h"
#import "WKTestViewcontrollerViewController.h"
#import "WKWebViewController.h"

@interface WKPlayGameViewController ()<UITableViewDataSource,UITableViewDelegate,WKCustomPopViewDelegate>

@end

@implementation WKPlayGameViewController
{
    WKCustomPopView *mCustomView;
    FDAlertView *WKCustomAlertView;
    
    UIView *mBgkView;
    
    MWGameObj *mGame;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self removeAlert];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"玩游戏";
    [self removeAlert];
    mGame = [MWGameObj new];
    self.tableArr = [NSMutableArray new];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    
    UINib   *nib = [UINib nibWithNibName:@"WKPlayGameCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    __weak __typeof(self)weakSelf = self;
    
    [self.tableView setRefreshWithHeaderBlock:^{
        [self removeAlert];

        [weakSelf tableViewHeaderReloadData];
    } footerBlock:^{
        [self removeAlert];

        [weakSelf tableViewFooterReloadData];
    }];
    
    [self.tableView setupEmptyData:^{
        [self removeAlert];

        [weakSelf tableViewHeaderReloadData];
        
    }];
    [self.tableView headerBeginRefreshing];
}
- (void)tableViewHeaderReloadData{
    [self removeAlert];

    [self.tableArr removeAllObjects];
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [MWBaseObj MWFetchGameList:@{} block:^(MWBaseObj *info, NSArray *mList) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self.tableArr addObjectsFromArray:mList];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [self.tableView headerEndRefreshing];

    }];

}
- (void)removeAlert{
    [mCustomView removeFromSuperview];
    [WKCustomAlertView hide];
    [WKCustomAlertView removeFromSuperview];
}
- (void)tableViewFooterReloadData{
    [self removeAlert];

    [self.tableView footerEndRefreshing];

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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.tableArr.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;

    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKPlayGameCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMGame:self.tableArr[indexPath.row]];
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"%ld行",indexPath.row);
//    WKTestViewcontrollerViewController *vc = [[WKTestViewcontrollerViewController alloc] initWithNibName:@"WKBaseSuperViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    MWGameObj *mGameInfo = self.tableArr[indexPath.row];
    mGame = mGameInfo;
    NSString *mcontent = [NSString stringWithFormat:@"本次游戏将消耗您%d个金币，您是否愿意玩本次游戏呢？",mGame.pay_coin_num];
    [self showCustomViewType:WKCustomPopViewHaveTwoBtn andTitle:[NSString stringWithFormat:@"您的账户还有%@个金币",[WKUser currentUser].gold] andContentTx:mcontent andOkBtntitle:@"确定" andCancelBtntitle:@"取消"];
    
}
///关闭按钮代理方法
- (void)WKCustomPopViewWithCloseBtnAction{
    MLLog(@"关闭");
//    [WKCustomAlertView hide];
    [mBgkView removeFromSuperview];
    [mCustomView removeFromSuperview];
}
///取消按钮代理方法
- (void)WKCustomPopViewWithCancelBtnAction{
    MLLog(@"取消");
//    [WKCustomAlertView hide];
    [mBgkView removeFromSuperview];
    [mCustomView removeFromSuperview];
}
///确定按钮代理方法
- (void)WKCustomPopViewWithOkBtnAction{
    MLLog(@"确定");
//    [WKCustomAlertView hide];
    [mBgkView removeFromSuperview];
    [mCustomView removeFromSuperview];
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [MWBaseObj MWPlayGame:@{@"member_id":[WKUser currentUser].member_id,@"game_id":mGame.game_id} block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            [SVProgressHUD dismiss];
            NSURL *path = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
            WKWebViewController *vc = [WKWebViewController new];
            vc.mPath = path;
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
    }];
    

}
#pragma mark----****----自定义弹出框
/**
 自定义弹出框
 
 @param mType 弹出框类型
 @param mTitle 标题
 @param mContent 内容
 @param mOkTitle 确定按钮
 @param mCancelTitle 取消按钮
 */
- (void)showCustomViewType:(WKCustomPopViewType)mType andTitle:(NSString *)mTitle andContentTx:(NSString *)mContent andOkBtntitle:(NSString *)mOkTitle andCancelBtntitle:(NSString *)mCancelTitle{
    
//    WKCustomAlertView = [[FDAlertView alloc] init];
    
    mBgkView = [UIView new];
    mBgkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    mBgkView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    [self.view addSubview:mBgkView];
    mCustomView = [WKCustomPopView initViewType:mType andTitle:mTitle andContentTx:mContent andOkBtntitle:mOkTitle andCancelBtntitle:mCancelTitle];
    mCustomView.delegate = self;
    
    mCustomView.frame = CGRectMake(30, DEVICE_Height/2-125, DEVICE_Width-60, 250);
    [mBgkView addSubview:mCustomView];
//    WKCustomAlertView.contentView = mCustomView;
//    [WKCustomAlertView show];
    
}

@end
