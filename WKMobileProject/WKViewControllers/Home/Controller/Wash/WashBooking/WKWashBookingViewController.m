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
    MWSchoolInfo *mSchoolInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mSchoolInfo = [MWSchoolInfo new];
    self.navigationItem.title = @"预约洗衣";
    
    [self addTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WKWashBookingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    
}
- (void)tableViewHeaderReloadData{
//    NSArray *mUserArr = [ZLPlafarmtLogin bg_findAll];
//
//    if (mUserArr.count>0) {
//        ZLPlafarmtLogin *mUserInfo = mUserArr[0];
//        MLLog(@"接档用户信息是：%@",mUserArr);
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:@"2" forKey:@"school_id"];
    [MWBaseObj MWFindSchoolList:para block:^(MWBaseObj *info, NSArray *mArr, MWSchoolInfo *mSchool) {
        
        if (info.err_code == 1) {
                [self.tableArr removeAllObjects];
            mSchoolInfo = mSchool;
                [self.tableArr addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
            }
        }];
        
        
//    }
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
    
    
    return self.tableArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKWashBookingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMType:WKBusy];
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    MWDeviceInfo *mDevice = self.tableArr[indexPath.row];
    cell.mContent.text = mDevice.location_name;
    cell.mWaiting.text = mDevice.school_name;
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
    mHeaderView.mContent.text = mSchoolInfo.school_name;
    return mHeaderView;
    
}
- (void)WKWashBookingCellBtnAction:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了%ld行",mIndexPath.row);
    MWDeviceInfo *mDevice = self.tableArr[mIndexPath.row];

    WaskBookingResultController *vc = [WaskBookingResultController new];
    vc.mDeviceInfo = mDevice;
    [self pushViewController:vc];
}

@end
