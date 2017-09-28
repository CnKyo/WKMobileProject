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
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的任务";
    
    CGFloat mY;
    if([[[WKGetDeviceInfo sharedLibrery]getDiviceName] isEqualToString:@"iphone X"] ){
        
        mY = 84;
    }else{
        mY = 64;
        
    }
    CGFloat mTY = mY+50;
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, mY, DEVICE_Width, 50) andTitleWithBtn:@[@"执行中",@"已提交",@"已结束"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
    [self.view addSubview:mSegmentView];
    
    mTableView = [UITableView new];
    mTableView.frame = CGRectMake(0, mTY, DEVICE_Width, DEVICE_Height-mTY);
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
    
    NSArray *arr = @[@"2017-2-5 12:10:06",
                     @"2017-3-5 12:10:06",
                     @"2017-7-10 18:6:16",
                     @"2017-8-5 18:10:06",
                     @"2017-10-5 18:10:06",
                     @"2017-7-10 18:6:16",
                     @"2017-8-5 18:10:06",
                     @"2017-9-5 18:10:06",
                     @"2017-10-5 18:10:06",
                     @"2017-6-5 12:10:06",
                     @"2020-7-10 18:6:16",
                     @"2017-8-5 18:10:06",
                     @"2017-9-5 18:10:06",
                     @"2017-10-5 18:10:06",
                     @"2017-8-5 18:10:06",
                     @"2017-9-5 18:10:06",
                     @"2017-10-5 18:10:06",
                     @"2017-8-5 18:10:06",
                     @"2007-10-5 18:10:06",
                     @"2017-8-5 18:10:06",
                     @"2017-9-5 18:10:06",
                     @"2017-10-5 18:10:06",
                     @"2017-8-5 18:10:06",
                     ];
    
    
    for (int i = 0; i < arr.count; i ++) {
        
        TimeModel *model = [TimeModel new];
        model.endTime = arr[i];
        [self.tableArr addObject:model];
    }
    
    //移除过时数据
    //    [self removeOutDate];
    [self.tableView reloadData];
    
}
- (void)tableViewFooterReloadData{
    MLLog(@"刷尾");
}
//移除过时数据
- (void)removeOutDate{
    
    for (NSInteger i = self.tableArr.count-1; i >= 0; i--) {
        
        TimeModel *model = self.tableArr[i];
        if ([self.countDown isOutDateWithModel:model]) {
            [self.tableArr removeObject:model];
        }
    }
}
- (ZJJTimeCountDown *)countDown{
    
    ZJJTimeCountDown *countDown = [super countDown];
    return countDown;
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

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 100, DEVICE_Width, 50) andTitleWithBtn:@[@"执行中",@"已提交",@"已结束"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
//    return mSegmentView;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
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
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WKMyTaskDetailViewController *vc = [WKMyTaskDetailViewController new];
    vc.mStatus = indexPath.row+1;
    [self pushViewController:vc];
}
- (void)MyTaskTableViewCellDelegateWithBtnAction:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了第：%ld个",mIndexPath.row);
    WKMyTaskDetailViewController *vc = [WKMyTaskDetailViewController new];
    vc.mStatus = mIndexPath.row+1;
    [self pushViewController:vc];
}

@end
