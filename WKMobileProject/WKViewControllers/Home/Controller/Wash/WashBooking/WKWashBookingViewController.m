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

#import "LTPickerView.h"

@interface WKWashBookingViewController ()<WKWashBookingCellDelegate>

@end

@implementation WKWashBookingViewController
{
    WKWashBookingHeaderView *mHeaderView;
    MWSchoolInfo *mSchoolInfo;
    
    MWSchoolInfo *mShoolObj;
    
    NSMutableArray *mShoolList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mSchoolInfo = [MWSchoolInfo new];
    self.navigationItem.title = @"预约洗衣";
    mShoolObj = [MWSchoolInfo new];
    mShoolList = [NSMutableArray new];
    [self addTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WKWashBookingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    
}
- (void)tableViewHeaderReloadData{
    [self.tableArr removeAllObjects];

    if (mShoolObj.schoolid.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先选择学校!"];
    }else{
        [SVProgressHUD showWithStatus:@"正在获取洗衣机信息!"];
        [MWBaseObj MWRegistGetSchoolInfo:@{@"school_id":mShoolObj.schoolid} block:^(MWBaseObj *info, NSArray *mArr) {
            if (info.err_code == 0) {
                [self.tableArr addObjectsFromArray:mArr];
                [SVProgressHUD showSuccessWithStatus:info.err_msg];
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
            }
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        }];
    }
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
    [cell setMDeviceInfo:self.tableArr[indexPath.row]];

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
    if (mShoolObj.schoolname.length==0) {
        mShoolObj.schoolname = @"请选择学校信息";
    }
    mHeaderView.mContent.text = mShoolObj.schoolname;
    [mHeaderView.mSelectedShollBtn addTarget:self action:@selector(mSelectedAction) forControlEvents:UIControlEventTouchUpInside];
    return mHeaderView;
    
}
#pragma mark----****----选择学校事件
- (void)mSelectedAction{
    [SVProgressHUD showWithStatus:@"正在获取学校信息!"];
    [MWBaseObj MWRegistGetSchoolInfo:@{@"school_id":@"0"} block:^(MWBaseObj *info, NSArray *mArr) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self initLTPickerView:mArr];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [SVProgressHUD dismiss];
    }];
}
- (void)initLTPickerView:(NSArray *)mList{
    
    NSMutableArray *mListArr = [NSMutableArray new];
    for (MWSchoolInfo *mShool in mList) {
        [mListArr addObject:mShool.schoolname];
    }
    
    LTPickerView *LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mListArr;//设置要显示的数据
    LtpickerView.defaultStr = mListArr[0];//默认选择的数据
    [LtpickerView show];//显示
    
    //回调block
    LtpickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        MLLog(@"选择了第%d行的%@",num,str);
        MWSchoolInfo *mShoolInfo = mList[num];
        mShoolObj = mShoolInfo;

        [self.tableView reloadData];
        [self tableViewHeaderReloadData];
        
    };

}
- (void)WKWashBookingCellBtnAction:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了%ld行",mIndexPath.row);
    MWDeviceInfo *mDevice = self.tableArr[mIndexPath.row];

    WaskBookingResultController *vc = [WaskBookingResultController new];
    vc.mDeviceInfo = mDevice;
    vc.mType = 2;
    vc.mCode = _mCode;
    [self pushViewController:vc];
}

@end
