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
@interface WKPlayGameViewController ()<UITableViewDataSource,UITableViewDelegate,WKCustomPopViewDelegate>

@end

@implementation WKPlayGameViewController
{
    WKCustomPopView *mCustomView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"玩游戏";
    self.tableArr = [NSMutableArray new];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    
    UINib   *nib = [UINib nibWithNibName:@"WKPlayGameCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    __weak __typeof(self)weakSelf = self;
    
    [self.tableView setRefreshWithHeaderBlock:^{
        [weakSelf tableViewHeaderReloadData];
    } footerBlock:^{
        [weakSelf tableViewFooterReloadData];
    }];
    
    [self.tableView setupEmptyData:^{
        [weakSelf tableViewHeaderReloadData];
        
    }];
    [self.tableView headerBeginRefreshing];
}
- (void)tableViewHeaderReloadData{
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
- (void)tableViewFooterReloadData{
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
    MWGameObj *mGame = self.tableArr[indexPath.row];
    NSString *mcontent = [NSString stringWithFormat:@"本次游戏将消耗您%d个金币，您是否愿意玩本次游戏呢？",mGame.pay_coin_num];
    [self showCustomViewType:WKCustomPopViewHaveTwoBtn andTitle:[NSString stringWithFormat:@"您的账户还有%@个金币",[WKUser currentUser].gold] andContentTx:mcontent andOkBtntitle:@"确定" andCancelBtntitle:@"取消"];
    
}
///关闭按钮代理方法
- (void)WKCustomPopViewWithCloseBtnAction{
    MLLog(@"关闭");
}
///取消按钮代理方法
- (void)WKCustomPopViewWithCancelBtnAction{
    MLLog(@"取消");
}
///确定按钮代理方法
- (void)WKCustomPopViewWithOkBtnAction{
    MLLog(@"确定");
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
    
    FDAlertView *alert = [[FDAlertView alloc] init];
    mCustomView = [WKCustomPopView initViewType:mType andTitle:mTitle andContentTx:mContent andOkBtntitle:mOkTitle andCancelBtntitle:mCancelTitle];
    mCustomView.delegate = self;
    
    mCustomView.frame = CGRectMake(30, 0, self.view.bounds.size.width-60, 250);
    alert.contentView = mCustomView;
    [alert show];
    
}

@end
