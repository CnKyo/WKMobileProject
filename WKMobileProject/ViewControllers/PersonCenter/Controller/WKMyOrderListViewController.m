//
//  WKMyOrderListViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyOrderListViewController.h"
#import "WKSegmentControl.h"
#import "WKHeader.h"
#import "WKHomeStatusCell.h"
#import "WKOrderDetail.h"
@interface WKMyOrderListViewController ()<WKSegmentControlDelagate,WKHomeStatusCellDelegate>

@end

@implementation WKMyOrderListViewController
{
    
    WKSegmentControl *mSegmentView;
    
    WKTransferType mType;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mType = 0;
    [self setMTitle:@"我的订单"];
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKHomeStatusCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 0, DEVICE_Width, 50) andTitleWithBtn:@[@"待接单",@"进行中",@"已完成"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor blueColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor blueColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return mSegmentView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

        return 190;

    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    
    CellId = @"cell";
    
    WKHomeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    
    WKOrderDetail *vc = [WKOrderDetail new];
    [self presentViewController:vc animated:YES completion:nil];

    
    
    
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    mType = mIndex;
    
}
@end
