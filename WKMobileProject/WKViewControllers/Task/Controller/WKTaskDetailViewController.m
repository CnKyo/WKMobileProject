
//
//  WKTaskDetailViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTaskDetailViewController.h"
#import "WKTaskDetailCell.h"

#import "WKTaskSectionHeaderView.h"


@interface WKTaskDetailViewController ()

@end

@implementation WKTaskDetailViewController
{
    WKHome *mH;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *mT = nil;
    
    if (_mType == WKTaskDetail) {
        mT = @"任务详情";
    }else{
     mT = @"活动详情";
    }
    
    self.navigationItem.title = mT;
    mH = [WKHome new];
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKTaskDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self addTableViewHeaderRefreshing];
}
- (void)tableViewHeaderReloadData{
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    if (_mType == WKTaskDetail) {
        [self.tableArr removeAllObjects];
        [para setObject:_mTask.task_id forKey:@"task_id"];

        WKUser *mU = [WKUser currentUser];
        MLLog(@"用户信息:%@",mU);
        
        [MWBaseObj MWGetTaskList:para block:^(MWBaseObj *info, NSArray *mBannerArr,NSArray *mList,NSArray *mArr) {
            if (info.err_code == 0) {
                [SVProgressHUD dismiss];
                [self.tableArr addObjectsFromArray:mList];
                [self.tableView reloadData];
                
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
            }
            
        }];
    }else{
    //    mT = @"活动详情";
        [self.tableArr removeAllObjects];
        [para setObject:_mAct.banner_id forKey:@"banner_id"];
        
        WKUser *mU = [WKUser currentUser];
        MLLog(@"用户信息:%@",mU);
        
        [MWBaseObj MWFetchActivityList:para block:^(MWBaseObj *info, NSArray *mArr) {
            if (info.err_code == 0) {
                [SVProgressHUD dismiss];
                if (mArr.count>0) {
                    mH = mArr[0];
                }
                [self.tableArr addObjectsFromArray:mArr];
                [self.tableView reloadData];
                
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
            }
            
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    if (_mType == WKTaskDetail) {
        return 1;
    }else{
        return 2;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_mType == WKTaskDetail) {
        return 125;
    }else{
        if (section == 0) {
            return 150;
        }else{
            return 80;
        }
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_mType == WKTaskDetail) {
        return self.tableArr.count;
    }else{
        if (section == 0) {
            return 0;
        }else{
            return self.tableArr.count;
        }
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_mType == WKTaskDetail) {
        WKTaskSectionHeaderView *mHeaderView = [WKTaskSectionHeaderView initView];
        mHeaderView.mTaskName.text = _mTask.task_title;
        mHeaderView.mPrice.text = [NSString stringWithFormat:@"¥%@/次",_mTask.task_price];
        mHeaderView.mResidue.text = [NSString stringWithFormat:@"剩余%@次",_mTask.task_leave_num];
        mHeaderView.mTaskTime.text = [NSString stringWithFormat:@"任务截止日期：%@",[Util WKTimeIntervalToDate:_mTask.task_end_time]];
        return mHeaderView;
    }else{
        if (section == 0) {
            NSMutableArray *mImgs = [NSMutableArray new];
            if (self.tableArr.count<=0) {
                return nil;
            }else{
                for (int i =0; i<self.tableArr.count; i++) {
                    WKHome *mBa = self.tableArr[i];
                    [mImgs addObject:[Util currentSourceImgUrl:mBa.banner_img]];
                }
                _mScrollerView = [[RKImageBrowser alloc] initWithFrame:CGRectMake(0, 0, screen_width, 150)];
                _mScrollerView.backgroundColor = [UIColor whiteColor];
                [_mScrollerView setBrowserWithImagesArray:mImgs];
                __weak __typeof(self)weakSelf = self;
                
                _mScrollerView.didselectRowBlock = ^(NSInteger clickRow) {
                    MLLog(@"333点击了图片%ld", clickRow);
                    
                };
                
                return _mScrollerView;
            }
            
        }else{
            WKTaskSectionHeaderView *mHeaderView = [WKTaskSectionHeaderView initActivityView];
            
            if (self.tableArr.count == 1) {
                WKHome *mObj = self.tableArr[0];
                mHeaderView.mTaskName.text = mObj.banner_title;
                if (mObj.add_time.length == 0 || [mObj.add_time isEqualToString:@""]) {
                    mObj.add_time = @"无";
                }
                mHeaderView.mTaskTime.text = [NSString stringWithFormat:@"发布时间：%@",mObj.add_time];

            }
            return mHeaderView;
        }
        
    }
 

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_mType == WKTaskDetail) {
        UIView *mFootView = [UIView new];
        mFootView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
        mFootView.backgroundColor = [UIColor colorWithRed:0.952941176470588 green:0.968627450980392 blue:0.992156862745098 alpha:1.00];
        
        UIButton *mCommitBtn = [UIButton new];
        mCommitBtn.frame = CGRectMake(0, 30, DEVICE_Width, 50);
        [mCommitBtn setTitle:@"领取任务" forState:0];
        [mCommitBtn setBackgroundColor:[UIColor colorWithRed:0.976470588235294 green:0.596078431372549 blue:0.27843137254902 alpha:1.00]];
        [mCommitBtn addTarget:self action:@selector(mFetchTaskAction:) forControlEvents:UIControlEventTouchUpInside];
        [mFootView addSubview:mCommitBtn];
        return mFootView;
    }else{
        return nil;
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_mType == WKTaskDetail) {
        return 80;

    }else{
        return 0;
    }
}
#pragma mark----****----领取任务
- (void)mFetchTaskAction:(UIButton *)sender{

    MLLog(@"领取任务");
    [SVProgressHUD showWithStatus:@"正在领取..."];
    [MWBaseObj MWFetchTask:@{@"task_id":_mTask.task_id,@"member_id":[WKUser currentUser].member_id} block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            [WKProgressView WKShowView:self.view andStatus:WKProgressSucess WithTitle:@"任务领取成功" andContent:@"您已成功领取任务，赶紧去做任务吧！\n任务完成后，请到“我的任务”提交任务单。" andBtnTitle:@"返回" andImgSRC:@"icon_paysucess" andBlock:^(WKProgressView *progressView, NSInteger btnIndex) {
                MLLog(@"%ld",btnIndex);
                [self popViewController];
            }];
            
        }else{
            [WKProgressView WKShowView:self.view andStatus:WKProgressError WithTitle:@"任务领取失败" andContent:info.err_msg andBtnTitle:@"返回重试" andImgSRC:@"icon_paysucess" andBlock:^(WKProgressView *progressView, NSInteger btnIndex) {
                MLLog(@"%ld",btnIndex);
//                [self popViewController];
            }];
        }
        [SVProgressHUD dismiss];

    }];
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 90;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKTaskDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_mType == WKTaskDetail) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.mLine.hidden = YES;
        MWTaskContent *mTask = self.tableArr[indexPath.row];

        [cell setMTask:mTask];
        
    }else{
        cell.backgroundColor = [UIColor colorWithRed:0.952941176470588 green:0.968627450980392 blue:0.992156862745098 alpha:1.00];
        cell.mLine.hidden = NO;
//        WKHome *mObj = self.tableArr[0];
//
        [cell setMActivity:mH];

    }
    return cell;

    
}

@end
