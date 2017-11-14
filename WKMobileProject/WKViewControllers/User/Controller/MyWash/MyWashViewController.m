//
//  MyWashViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "MyWashViewController.h"
#import "WKMyWashCell.h"
#import "WKMyWashDetailViewController.h"
@interface MyWashViewController ()<WKSegmentControlDelagate,WKMyWashCellDelegate>

@end

@implementation MyWashViewController
{
    WKSegmentControl *mSegmentView;

    NSInteger mType;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的洗衣";
    mType = 0;
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKMyWashCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 100, DEVICE_Width, 50) andTitleWithBtn:@[@"全部",@"超时返还",@"已完成"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");
    self.mPage = 0;

    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [self.tableArr removeAllObjects];

    [MWBaseObj MWGetMyWashOrderList:@{@"member_id":[WKUser currentUser].member_id,@"page":NumberWithInt(self.mPage),@"order_type":[NSString stringWithFormat:@"%ld",mType],@"order_id":@"0"} block:^(MWBaseObj *info, NSArray *mList) {
        if (info.err_code == 0) {
            
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self.tableArr addObjectsFromArray:mList];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [self.tableView reloadData];

    }];
    
}
- (void)tableViewFooterReloadData{
    MLLog(@"刷尾");
    self.mPage += 10;
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [self.tableArr removeAllObjects];
    
    [MWBaseObj MWGetMyWashOrderList:@{@"member_id":[WKUser currentUser].member_id,@"page":NumberWithInt(self.mPage),@"order_type":[NSString stringWithFormat:@"%ld",mType]} block:^(MWBaseObj *info, NSArray *mList) {
        if (info.err_code == 0) {
            
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self.tableArr addObjectsFromArray:mList];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [self.tableView reloadData];

    }];
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
    

    mType = mIndex+2;
    if (mType == 2) {
        mType = 0;
    }
    [self tableViewHeaderReloadData];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return mSegmentView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKMyWashCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    [cell setMWashObj:self.tableArr[indexPath.row]];
    return cell;
    
}
- (void)UITableViewCellDidSelectedIndexPath:(NSIndexPath*)mIndexPath{
    MLLog(@"点击了%ld行",mIndexPath.row);
    
    WKMyWashDetailViewController *vc = [WKMyWashDetailViewController new];
    vc.mWash = self.tableArr[mIndexPath.row];
    vc.mType = mType;
    [self pushViewController:vc];
}

@end
