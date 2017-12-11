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

@interface WKPlayGameViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WKPlayGameViewController
{
  
    MWGameObj *mGame;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"玩游戏";
    mGame = [MWGameObj new];
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
    MWGameObj *mGameInfo = self.tableArr[indexPath.row];
    mGame = mGameInfo;
    NSString *mcontent = [NSString stringWithFormat:@"本次游戏将消耗您%d个金币，您是否愿意玩本次游戏呢？",mGame.pay_coin_num];
    
    WKAlertView *mAlert = [WKAlertView alertTitle:[NSString stringWithFormat:@"您的账户还有%@个金币",[WKUser currentUser].gold] andTitleTextColor:[UIColor whiteColor] andLineViewColor:[UIColor colorWithRed:220/255.0 green:221/255.0 blue:221/255.0 alpha:1] andTitleBgkColor:[UIColor colorWithRed:0.25 green:0.58 blue:0.94 alpha:1] andHideCloseBtn:NO andHideLineView:NO andCornerRadius:0 andMessage:mcontent];
    
    mAlert.butttonCancelBgColor = [UIColor colorWithRed:0.97 green:0.58 blue:0.27 alpha:1];
    mAlert.butttonConfirmBgColor = [UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1];
    [mAlert addAction:[WKAlertAction actionTitle:@"确定" style:WKAlertActionCancel handler:^(WKAlertAction *action) {
        MLLog(@"确定确定确定确定");
        
        [SVProgressHUD showWithStatus:@"正在加载中..."];
        [MWBaseObj MWPlayGame:@{@"member_id":[WKUser currentUser].member_id,@"game_id":mGame.game_id} block:^(MWBaseObj *info) {
            if (info.err_code == 0) {
                [SVProgressHUD dismiss];
                NSURL *path = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
                WKWebViewController *vc = [WKWebViewController new];
                vc.mURLString = mGame.game_url;
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
            }
        }];
    }]];
    [mAlert addAction:[WKAlertAction actionTitle:@"取消" style:WKAlertActionConfirm handler:^(WKAlertAction *action) {
        MLLog(@"取消取消取消取消");
        
    }]];
    [mAlert show];
    
}



@end
