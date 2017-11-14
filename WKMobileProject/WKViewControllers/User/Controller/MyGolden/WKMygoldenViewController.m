//
//  WKMygoldenViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMygoldenViewController.h"
#import "WKMyGoldenCell.h"
@interface WKMygoldenViewController ()<WKSegmentControlDelagate>

@end

@implementation WKMygoldenViewController
{
    WKSegmentControl *mSegmentView;
    
    
    NSInteger mType;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"金币记录";
    mType = 0;
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKMyGoldenCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 0, DEVICE_Width, 50) andTitleWithBtn:@[@"全部",@"待付款",@"已完成"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");
    self.mPage = 0;
    [self.tableArr removeAllObjects];
    [MWBaseObj MWGetGoldHistoryList:@{@"member_id":[WKUser currentUser].member_id,@"income_expenditure":[NSString stringWithFormat:@"%ld",mType],@"page":NumberWithInt(self.mPage)} block:^(MWBaseObj *info, NSArray *mList) {
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
    MLLog(@"刷尾");
    self.mPage += 10;
    [MWBaseObj MWGetGoldHistoryList:@{@"member_id":[WKUser currentUser].member_id,@"income_expenditure":[NSString stringWithFormat:@"%ld",mType],@"page":NumberWithInt(self.mPage)} block:^(MWBaseObj *info, NSArray *mList) {
        if (info.err_code == 0) {
            
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self.tableArr addObjectsFromArray:mList];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
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
    mType = mIndex;
    if (mIndex == 2) {
        mType = -1;
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
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *mBtn = [UIButton new];
    mBtn.backgroundColor = [UIColor colorWithRed:0.972549019607843 green:0.584313725490196 blue:0.270588235294118 alpha:1.00];
    [mBtn setTitle:[NSString stringWithFormat:@"一共%@个金币",[WKUser currentUser].gold] forState:0];
    return mBtn;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKMyGoldenCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMGold:self.tableArr[indexPath.row]];
    return cell;
    
}


@end
