//
//  WKMyOrderViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyOrderViewController.h"
#import "WKMyOrderCell.h"
#import "WKMyOrderDetailViewController.h"
@interface WKMyOrderViewController ()<WKSegmentControlDelagate>

@end

@implementation WKMyOrderViewController
{
    WKSegmentControl *mSegmentView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的订单";
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKMyOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");
}
- (void)tableViewFooterReloadData{
    MLLog(@"刷尾");
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
#pragma mark----****---- 分段选择控件
///选择了哪一个？
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    [self tableViewHeaderReloadData];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 100, DEVICE_Width, 50) andTitleWithBtn:@[@"全部",@"待付款",@"已完成"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
    return mSegmentView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 185;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了%ld行",indexPath.row);
    
    WKMyOrderDetailViewController *vc = [WKMyOrderDetailViewController new];
    [self pushViewController:vc];

}
@end
