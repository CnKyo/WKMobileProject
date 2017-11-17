//
//  WKMyTaskDetailViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyTaskDetailViewController.h"
#import "WKMyTaskDetailHeadCell.h"
#import "WKMyTaskDetailCommitCell.h"

#import "WKTaskDetailCell.h"
@interface WKMyTaskDetailViewController ()<WKMyTaskDetailCommitCellDelagate>

@end

@implementation WKMyTaskDetailViewController
{
    NSInteger mImgNum;
    
    MWTaskObj *mMyTask;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"任务详情";
    
    mImgNum = 0;
    mMyTask = [MWTaskObj new];
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKMyTaskDetailHeadCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"headCell"];
    
    nib = [UINib nibWithNibName:@"WKTaskDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"detailCell"];
    
    nib = [UINib nibWithNibName:@"WKMyTaskDetailCommitCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"commitCell"];
    
    [self addTableViewHeaderRefreshing];

    
    UIView *mFooterView = [UIView new];
    mFooterView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
    mFooterView.backgroundColor = [UIColor whiteColor];
    
    UIButton *mLogOut = [UIButton new];
    mLogOut.layer.cornerRadius = 4;
    mLogOut.frame = CGRectMake(0, 15, DEVICE_Width, 50);
    mLogOut.backgroundColor = [UIColor colorWithRed:0.97 green:0.58 blue:0.27 alpha:1];
    [mLogOut setTitle:@"提交任务" forState:0];
    [mLogOut addTarget:self action:@selector(mCommitAction) forControlEvents:UIControlEventTouchUpInside];
    [mFooterView addSubview:mLogOut];
    
    self.tableView.tableFooterView = mFooterView;
    
}
- (void)mCommitAction{
    [SVProgressHUD showWithStatus:@"正在提交..."];
    [MWBaseObj MWCommitTaskOrder:@{@"member_id":[WKUser currentUser].member_id,@"task_record_id":_mTask.task_record_id} block:^(MWBaseObj *info) {
        if(info.err_code == 0){
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self popViewController];
//            [self tableViewHeaderReloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [SVProgressHUD dismiss];
        
    }];
        
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");
        
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [MWBaseObj MWGetMyTaskOrderDetail:@{@"task_id":_mTask.task_id} block:^(MWBaseObj *info,MWTaskObj *mTaskDetailObj) {
        if (info.err_code == 0) {
            mMyTask = mTaskDetailObj;
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
           
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        if (_mStatus == Going) {
            return 1;
        }else{
            return 1;
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 280;
    }else{
        if (_mStatus == Going) {
            
            return 450;
        }else{
            return 90;
        }
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    if (indexPath.section == 0) {
        reuseCellId = @"headCell";
        
        WKMyTaskDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_mStatus == Going) {
            cell.mStatusH.constant = 0;
        }else{
            cell.mStatusH.constant = 20;
            
        }
    
        cell.mTaskName.text = _mTask.task_title;
        cell.mTaskPrice.text = [NSString stringWithFormat:@"任务酬劳：%@元",mMyTask.task_price];
        cell.mTaskEndTime.text = [NSString stringWithFormat:@"任务截止时间:%@",[Util WKTimeIntervalToDate:mMyTask.complete_time]];
        cell.mStatusContent.text = [NSString stringWithFormat:@"进行中,请耐心等待!"];
        cell.mTaskStatus.text = [NSString stringWithFormat:@"当前任务状态：%@",_mTask.task_complete_rate];
        cell.mTaskExplain.text = mMyTask.task_describe;
        cell.mTaskResidueNum.text = [NSString stringWithFormat:@"任务剩余量：%@",mMyTask.task_leave_num];
        
        return cell;
    }else{
        if (_mStatus == Going) {
            reuseCellId = @"commitCell";
            
            WKMyTaskDetailCommitCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell initPickView];
            return cell;
        }else{
            reuseCellId = @"detailCell";
            
            WKTaskDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mTitle.text = mMyTask.task_title;
            cell.mContent.text = mMyTask.task_step;
            return cell;
        }
        
    }
    
}

/**
 cell按钮代理方法
 
 @param mTag 1:微信转发。  2:外网注册。  3：立即提交。
 */
- (void)WKMyTaskDetailCommitCellWithBtnClicked:(NSInteger)mTag{
    MLLog(@"点击了:%ld",mTag);
}
- (void)WKMyTaskDetailCommitCellWithTextViewEndEditing:(NSString *)mText{
    MLLog(@"备注的内容是：%@",mText);
}
/**
 选择图片代理方法
 
 @param mImgArr 返回图片数组
 */
- (void)WKMyTaskDetailCommitCellWithReturnImgs:(NSArray *)mImgArr{
    if (mImgArr.count>0) {
        for (HXPhotoModel *model in mImgArr) {
            // 在这里取到模型的数据
            MLLog(@"%@",model.fileURL);
        }
        
    }
    
}
@end
