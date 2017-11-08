//
//  WKTaskViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTaskViewController.h"
#import "WKTaskTableViewCell.h"
#import "WKTaskHeaderCell.h"
#import "WKTaskDetailViewController.h"
#import "FSCustomButton.h"
#import "WKMyTaskViewController.h"
#import "WKWashPayResultView.h"

@interface WKTaskViewController ()<WKTaskHeaderCellDelegate>

@end

@implementation WKTaskViewController
{
    
    ///banner数据源
    NSMutableArray *mBannerArr;
    WKWashPayResultView *mSucessView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"任务赚财富";

    mBannerArr = [NSMutableArray new];

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKTaskTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mainCell"];

    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
    
    [self.tableView removeFromSuperview];
    
//    FSCustomButton *mLeftBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(0, 220, 120, 40)];
//    mLeftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    [mLeftBtn setTitle:@"我的任务" forState:UIControlStateNormal];
//    [mLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [mLeftBtn setImage:[UIImage imageNamed:@"task_money"] forState:UIControlStateNormal];
//    mLeftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
//    mLeftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0);
//    [mLeftBtn addTarget:self action:@selector(myTaskOrder) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *mLeftItem = [[UIBarButtonItem alloc]initWithCustomView:mLeftBtn];
//    self.navigationItem.leftBarButtonItem = mLeftItem;
//
//    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"service"]];
//    [self setRightBtnImage:@"service"];
    [self initSucessView];

}
#pragma mark----****----初始化支付成功和失败view
- (void)initSucessView{
    mSucessView = [WKWashPayResultView initVIPSucessView];
    mSucessView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height);
    mSucessView.mTopupMessageContent.hidden = YES;
    mSucessView.mTopupStatus.text = @"建设中";
    [mSucessView.mTopupBackBtn setTitle:@"敬请期待..." forState:0];
    [self.view addSubview:mSucessView];
}
- (void)myTaskOrder{
    MLLog(@"我的任务");
    WKMyTaskViewController *vc = [WKMyTaskViewController new];
    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
    [self pushViewController:vc];
}
- (void)rightBtnAction{
    MLLog(@"客服");

}
- (void)tableViewHeaderReloadData{
    [mBannerArr removeAllObjects];
    NSArray *mArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1493199772&di=66346cd79eed9c8cb4ec03c3734d0b31&src=http://img15.3lian.com/2015/f2/128/d/123.jpg",@"http://wmtp.net/wp-content/uploads/2017/04/0420_sweet945_1.jpeg",@"http://wmtp.net/wp-content/uploads/2017/04/0407_shouhui_1.jpeg"];
    [mBannerArr addObjectsFromArray:mArr];
    
    [self.tableView reloadData];
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:kMobTrainDemandKey forKey:@"key"];
    [para setObject:@"K688" forKey:@"trainno"];
    
    [self showWithLoading:@"loading..."];
    [WKBaseInfo WKFindTrainNumber:para block:^(WKBaseInfo *info, NSArray *list) {
        if (info.status == kRetCodeSucess) {
            [self showSucess:info.msg];
        }else{
            [self showError:info.msg];
        }
    }];
}
- (void)tableViewFooterReloadData{
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
   
    return 0;
   
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        return 4;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }else{
        return 90;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 1) {
        reuseCellId = @"mainCell";
        
        WKTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *cellID = @"cellID";
       
        WKTaskHeaderCell *cell = [[WKTaskHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID data:mBannerArr];
        cell.delegate = self;
        return cell;
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        MLLog(@"%ld行",indexPath.row);
        WKTaskDetailViewController *vc = [WKTaskDetailViewController new];
        vc.mType = WKTaskDetail;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}
- (void)WKTaskHeaderCellBannerClicked:(NSInteger)mIndex{
    MLLog(@"选择了:%ld",mIndex);

}

@end
