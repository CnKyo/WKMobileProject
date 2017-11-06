//
//  WKUserViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserViewController.h"

#import "WKUserInfoCell.h"
#import "WKUserInfoAdCell.h"
#import "WKUserFuncCell.h"

#import "WKUserMsgViewController.h"
#import "WKEditUserinfoViewController.h"
#import "WKJoinusViewController.h"
#import "WKMyActivityViewController.h"
#import "MyWashViewController.h"
#import "WKMyOrderViewController.h"
#import "WKMygoldenViewController.h"
#import "WKConnectViewController.h"
#import "WKMyWealthViewController.h"
#import "WKMyTaskViewController.h"
#import "UIScrollView+DREmptyDataSet.h"
#import "UIScrollView+DRRefresh.h"

#import <BGFMDB.h>
@interface WKUserViewController ()<WKUserInfoCellDelegate,WKUserInfoAdCellDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation WKUserViewController
{

    NSArray *mFuncArr;
    NSArray *mIamgeArr;

    
    ZLPlafarmtLogin *mUserInfo;

}
//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarHairlineImageView.hidden = YES;

}
//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    self.view.backgroundColor = M_CO;
    self.tableArr = [NSMutableArray new];
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    UIButton *mRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_Width-60,15,25,25)];
    mRightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    mRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [mRightBtn setImage:[UIImage imageNamed:@"icon_user_message"] forState:UIControlStateNormal];
    [mRightBtn addTarget:self action:@selector(rightBtnAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mRightBartem = [[UIBarButtonItem alloc]initWithCustomView:mRightBtn];
    self.navigationItem.rightBarButtonItem= mRightBartem;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"WKUserInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"headerCell"];
    
    nib = [UINib nibWithNibName:@"WKUserInfoAdCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"adCell"];
    
    nib = [UINib nibWithNibName:@"WKUserFuncCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"funcCell"];
    
    
    mFuncArr = @[@"我的活动",@"我的洗衣",@"我的任务",@"我的订单",@"帮助中心",@"加入我们",@"联系我们"];
    mIamgeArr = @[@"my_activity",@"my_laundry",@"my_task",@"my_order",@"help",@"join_us",@"contact_us"];
    __weak __typeof(self)weakSelf = self;
    
    [self.tableView setRefreshWithHeaderBlock:^{
        [weakSelf tableViewHeaderReloadData];
    } footerBlock:^{

    }];

    [self.tableView headerBeginRefreshing];
    
    NSArray *mUserArr = [ZLPlafarmtLogin bg_findAll];
    
    if (mUserArr.count>0) {
        mUserInfo = mUserArr[0];
        MLLog(@"接档用户信息是：%@",mUserArr);
       
    }
}
- (void)tableViewHeaderReloadData{
    NSMutableDictionary *mWechat = [NSMutableDictionary new];
    [mWechat setObject:kMobTrainDemandKey forKey:@"key"];
    [mWechat setObject:@"3" forKey:@"cid"];
    [mWechat setObject:@"1" forKey:@"page"];
    [mWechat setObject:@"2" forKey:@"size"];
    
    
    [WKWechatObj WKGetWechat:mWechat block:^(WKBaseInfo *info, NSArray *mArr) {
        
        if (info.status == kRetCodeSucess) {
            [SVProgressHUD dismiss];
            [self.tableArr removeAllObjects];
            [self.tableArr addObjectsFromArray:mArr];
            
            
            [self.tableView reloadData];
            
        }else{
            [SVProgressHUD dismiss];
        }
        [self.tableView headerEndRefreshing];

        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBtnAction{
    MLLog(@"消息");
    
    WKUserMsgViewController *vc = [WKUserMsgViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
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
    
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        return 15;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }else{
  
        UIView *mSectionView = [UIView new];
        mSectionView.backgroundColor = [UIColor colorWithRed:0.956862745098039 green:0.972549019607843 blue:0.996078431372549 alpha:1.00];
        return mSectionView;
    }
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.tableArr.count/2;
    }else{
        return mFuncArr.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }else if(indexPath.section == 1){
        return 120;
    }else{
        return 50;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"headerCell";
        
        WKUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMPressValue:@"0.5"];
        [cell setMUserInfo:mUserInfo];
        cell.delegete = self;

        return cell;
    }else if(indexPath.section == 1){
        reuseCellId = @"adCell";
        
        WKUserInfoAdCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegete = self;
        
        WKWechatObj *mN1 = self.tableArr[indexPath.row*2];
        WKWechatObj *mN2;
        if ((indexPath.row+1)*2>self.tableArr.count) {
            cell.mRightImg.hidden = YES;
        }else{
            mN2 = self.tableArr[indexPath.row*2+1];
            cell.mRightImg.hidden = NO;
            
        }
        [cell.mLeftImg sd_setImageWithURL:[NSURL URLWithString:mN1.thumbnails] placeholderImage:nil];
        [cell.mRightImg sd_setImageWithURL:[NSURL URLWithString:mN2.thumbnails] placeholderImage:nil];
        
        return cell;
    }else{
        
        reuseCellId = @"funcCell";
        
        WKUserFuncCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.mName.text = mFuncArr[indexPath.row];
        cell.mImage.image = [UIImage imageNamed:mIamgeArr[indexPath.row]];
        return cell;
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        MLLog(@"%ld行",indexPath.row);
        switch (indexPath.row) {
            case 0:
            {
            WKMyActivityViewController *vc = [WKMyActivityViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
            }
                break;
            case 1:
            {
            MyWashViewController *vc = [MyWashViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
            }
                break;
            case 2:
            {
            WKMyTaskViewController *vc = [WKMyTaskViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
            }
                break;
            case 3:
            {
            WKMyOrderViewController *vc = [WKMyOrderViewController new];

      
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
            }
                break;
            case 4:
            {
            WKConnectViewController *vc = [WKConnectViewController new];
 
            vc.mType = WKHelpCenter;

            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
            }
                break;
            case 5:
            {
            WKJoinusViewController *vc = [WKJoinusViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
            }
                break;
            case 6:
            {
            WKConnectViewController *vc = [WKConnectViewController new];
            vc.mType = WKConnectUs;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
            }
                break;
                
            default:
                break;
        }
    }
    
}


#pragma mark----****----cell的代理方法
/**
 用户header按钮点击代理方法
 
 @param mTag 返回索引(0修改用户资料,1签到,2财富值,3金币)
 */
- (void)WKUserInfoCellDelegateWithBtnClicked:(NSInteger)mTag{
    MLLog(@"选择的是:%ld",mTag);
    switch (mTag) {
        case 0:
        {
        WKEditUserinfoViewController *vc = [WKEditUserinfoViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
        
        }
            break;
        case 1:
        {
        [SVProgressHUD showSuccessWithStatus:@"签到成功！"];
        }
            break;
        case 2:
        {
        WKMyWealthViewController *vc = [WKMyWealthViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
        }
            break;
        case 3:
        {
        WKMygoldenViewController *vc = [WKMygoldenViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
        }
            break;
            
        default:
            break;
    }
}

/**
 左边按钮点击代理方法
 
 @param mIndexPath 返回索引
 */
- (void)WKUserInfoAdCellDelegateWithLeftBtn:(NSIndexPath *)mIndexPath{
    MLLog(@"选择的是:%ld",mIndexPath.row);

}
/**
 右边按钮点击代理方法
 
 @param mIndexPath 返回索引
 */
- (void)WKUserInfoAdCellDelegateWithRightBtn:(NSIndexPath *)mIndexPath{
    MLLog(@"选择的是:%ld",mIndexPath.row);

}
@end
