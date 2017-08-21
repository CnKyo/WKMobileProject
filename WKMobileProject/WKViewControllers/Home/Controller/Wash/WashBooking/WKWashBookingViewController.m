//
//  WKWashBookingViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashBookingViewController.h"
#import "WKWashBookingHeaderView.h"
#import "WKWashBookingCell.h"
#import "WaskBookingResultController.h"
@interface WKWashBookingViewController ()<WKWashBookingCellDelegate>

@end

@implementation WKWashBookingViewController
{
    WKWashBookingHeaderView *mHeaderView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"预约洗衣";
    
    [self addTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WKWashBookingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKWashBookingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMType:WKBusy];
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 70;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    mHeaderView = [WKWashBookingHeaderView initView];
    return mHeaderView;
    
}
- (void)WKWashBookingCellBtnAction:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了%ld行",mIndexPath.row);
    WaskBookingResultController *vc = [WaskBookingResultController new];
    [self pushViewController:vc];
}

@end
