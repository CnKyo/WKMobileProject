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

#import "TimeModel.h"
@interface WKMyTaskViewController ()<MyTaskTableViewCellDelegate,WKSegmentControlDelagate>

@end

@implementation WKMyTaskViewController
{
    WKSegmentControl *mSegmentView;
    UITableView *mTableView;
    NSInteger mType;
    NSMutableArray *mTableArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的任务";
    mTableArr = [NSMutableArray new];
    mType = 1;

    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 0, DEVICE_Width, 50) andTitleWithBtn:@[@"执行中",@"已提交",@"已结束"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
    
    mTableView = [UITableView new];
    mTableView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    self.tableView = mTableView;
    //    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"MyTaskTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");
    
    self.mPage = 0;
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [self.tableArr removeAllObjects];
    [mTableArr removeAllObjects];
    [MWBaseObj MWGETMyTaskOrderList:@{@"member_id":[WKUser currentUser].member_id,@"complete_status":[NSString stringWithFormat:@"%ld",mType],@"page":NumberWithInt(self.mPage)} block:^(MWBaseObj *info, NSArray *mList) {
        if (info.err_code == 0) {
            
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [mTableArr addObjectsFromArray:mList];
            for (MWMyTaskOrderObj *mTask in mList) {
                
                    TimeModel *model = [TimeModel new];
                    model.endTime = [Util WKTimeIntervalToDate:mTask.task_end_time];
                    [self.tableArr addObject:model];

            }
            [self.tableView reloadData];

        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }

    }];
    
}
- (void)tableViewFooterReloadData{
    MLLog(@"刷尾");
    self.mPage += 10;
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [MWBaseObj MWGETMyTaskOrderList:@{@"member_id":[WKUser currentUser].member_id,@"complete_status":[NSString stringWithFormat:@"%ld",mType],@"page":NumberWithInt(self.mPage)} block:^(MWBaseObj *info, NSArray *mList) {
        if (info.err_code == 0) {
            
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [mTableArr addObjectsFromArray:mList];
            for (MWMyTaskOrderObj *mTask in mList) {
                
                TimeModel *model = [TimeModel new];
                model.endTime = [Util WKTimeIntervalToDate:mTask.task_end_time];
                [self.tableArr addObject:model];
                
            }
            [self.tableView reloadData];

        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }

    }];
}
////移除过时数据
//- (void)removeOutDate{
//
//    for (NSInteger i = mTableArr.count-1; i >= 0; i--) {
//
//        TimeModel *model = mTableArr[i];
//        if ([self.countDown isOutDateWithModel:model]) {
//            [mTableArr removeObject:model];
//        }
//    }
//}

//- (ZJJTimeCountDown *)countDown{
//    
//    ZJJTimeCountDown *countDown = [super countDown];
//    return countDown;
//}
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
    mType = mIndex+1;

    [self tableViewHeaderReloadData];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 100, DEVICE_Width, 50) andTitleWithBtn:@[@"执行中",@"已提交",@"已结束"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
    return mSegmentView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mTableArr.count;
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
    
    TimeModel *model = self.tableArr[indexPath.row];

    //必须设置所显示的行
    cell.mCountTime.indexPath = indexPath;
    //在不设置为过时自动删除情况下 滑动过快的时候时间不会闪
    cell.mCountTime.text = [self.countDown countDownWithModel:model timeLabel:cell.mCountTime];
    [cell setMTask:mTableArr[indexPath.row]];
    if(mType == 2 || mType == 3){
        cell.mCommitBtn.hidden = YES;
    }else{
        cell.mCommitBtn.hidden = NO;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WKMyTaskDetailViewController *vc = [WKMyTaskDetailViewController new];
    vc.mStatus = mType+1;
    vc.mTask = mTableArr[indexPath.row];
    vc.mTaskType = mType;
    [self pushViewController:vc];
}
- (void)MyTaskTableViewCellDelegateWithBtnAction:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了第：%ld个",mIndexPath.row);
//    WKMyTaskDetailViewController *vc = [WKMyTaskDetailViewController new];
//    vc.mStatus = mIndexPath.row+1;
//    [self pushViewController:vc];
    MWMyTaskOrderObj *mTask = mTableArr[mIndexPath.row];

    [SVProgressHUD showWithStatus:@"正在提交..."];
    [MWBaseObj MWCommitTaskOrder:@{@"member_id":[WKUser currentUser].member_id,@"task_record_id":mTask.task_record_id} block:^(MWBaseObj *info) {
        if(info.err_code == 0){
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            
            [self tableViewHeaderReloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [SVProgressHUD dismiss];
        
    }];
    
    
}
- (ZJJTimeCountDown *)countDown{
    
    if (!_countDown) {
        _countDown = [[ZJJTimeCountDown alloc] initWithScrollView:self.tableView dataList:self.tableArr];
        _countDown.delegate = self;
    }
    return _countDown;
}
- (void)scrollViewWithAutomaticallyDeleteModel:(id)model{
    
    MLLog(@"==model:%@===endTime=%@===",model,[model valueForKey:@"endTime"]);
}
- (void)dealloc {
    /// 2.销毁
    [_countDown destoryTimer];
}
@end
