//
//  WKPlayGameViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKPlayGameViewController.h"
#import "WKPlayGameCell.h"
@interface WKPlayGameViewController ()

@end

@implementation WKPlayGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"玩游戏";
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKPlayGameCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
}
- (void)tableViewHeaderReloadData{

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
    
    return 0;
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 14;

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

    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"%ld行",indexPath.row);
    
    
    [self showCustomViewType:WKCustomPopViewHaveTwoBtn andTitle:@"您的账户还有100000000个金币" andContentTx:@"本次游戏将消耗您120000个金币，您是否愿意玩本次游戏呢？" andOkBtntitle:@"确定" andCancelBtntitle:@"取消"];
    
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
@end
