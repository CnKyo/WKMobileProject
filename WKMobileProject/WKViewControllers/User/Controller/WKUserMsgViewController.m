//
//  WKUserMsgViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserMsgViewController.h"
#import "WKUserMsgCell.h"
#import "WKUserMsgDetailViewController.h"
@interface WKUserMsgViewController ()

@end

@implementation WKUserMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKUserMsgCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
    
}
- (void)tableViewHeaderReloadData{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self.tableArr removeAllObjects];
    [MWBaseObj MWGetMessageList:@{@"member_id":[WKUser currentUser].member_id,@"message_id":@"0"} block:^(MWBaseObj *info, NSArray *mList) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self.tableArr addObjectsFromArray:mList];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
    }];
}
- (void)tableViewFooterReloadData{

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

    return 15;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

        
    UIView *mSectionView = [UIView new];
    mSectionView.backgroundColor = [UIColor clearColor];
    return mSectionView;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.tableArr.count;
 
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
   
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    
    reuseCellId = @"cell";
    
    WKUserMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setMMSG:self.tableArr[indexPath.row]];
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"%ld行",indexPath.row);
    
    WKUserMsgDetailViewController *vc = [WKUserMsgDetailViewController new];
    vc.mMsg = self.tableArr[indexPath.row];
    [self pushViewController:vc];
}

@end
