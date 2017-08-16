//
//  WKMyTaskViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyTaskViewController.h"
#import "MyTaskTableViewCell.h"
#import "WKMyTaskDetailViewController.h"
@interface WKMyTaskViewController ()<MyTaskTableViewCellDelegate,WKSegmentControlDelagate>

@end

@implementation WKMyTaskViewController
{
    WKSegmentControl *mSegmentView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的任务";
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"MyTaskTableViewCell" bundle:nil];
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
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 100, DEVICE_Width, 50) andTitleWithBtn:@[@"执行中",@"已提交",@"已结束"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
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
    return 165;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    MyTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    return cell;
    
}

- (void)MyTaskTableViewCellDelegateWithBtnAction:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了第：%ld个",mIndexPath.row);
    WKMyTaskDetailViewController *vc = [WKMyTaskDetailViewController new];
    vc.mStatus = mIndexPath.row+1;
    [self pushViewController:vc];
}

@end
