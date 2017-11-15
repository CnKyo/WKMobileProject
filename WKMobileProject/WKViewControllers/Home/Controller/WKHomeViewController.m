//
//  WKHomeViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKHomeViewController.h"
#import "WKHeader.h"
#import "WKHomeTypeHeaderCell.h"
#import "WKHomeHeaderSectionView.h"
#import "WKHomeDecomandedCell.h"
#import "WKHomeActivityCell.h"

#import "WKWashViewController.h"
#import "WKVipTopupViewController.h"
#import "WKBuyGoldenViewController.h"

#import "WKGenericLoginViewController.h"

#import "FCIPAddressGeocoder.h"
#import "UIScrollView+DREmptyDataSet.h"
#import "UIScrollView+DRRefresh.h"
#import "WKWebViewController.h"

#import <BGFMDB.h>

#import "CurentLocation.h"

@interface WKHomeViewController ()<WKHomeTypeHeaderCellDelegate,WKHomeDecomandedCellDelegate,NSNetworkMonitorProtocol,MMApBlockCoordinate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTopMargin;


///网络状态 
@property (strong,nonatomic) NSString *mNetWorkStatus;

@end

@implementation WKHomeViewController{

    ///banner数据源
    NSMutableArray *mTopBannerArr;
    NSMutableArray *mJHBannerArr;

    NSMutableArray *mFuncArr;
    
    NSMutableArray *mRecommend;
    NSMutableArray *mActArr;

    ///列表分组viewinf
    WKHomeHeaderSectionView *mSectionView;
    
    MWHomeNoticeObj *mNoticeObj;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    mNoticeObj = [MWHomeNoticeObj new];
    mRecommend = [NSMutableArray new];
    mActArr = [NSMutableArray new];
    UIImage *image = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = image;
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.96 green:0.43 blue:0.01 alpha:1]} forState:UIControlStateSelected];
    
    const NSString *deviceName = [[DeviceInfoManager sharedManager] getDeviceName];
    MLLog(@"deviceName:%@",deviceName);
    if ([[[WKGetDeviceInfo sharedLibrery] getDiviceName] isEqualToString:@"Global_iPhone_X"] || [[[WKGetDeviceInfo sharedLibrery] getDiviceName] isEqualToString:@"Chinese_iPhone_X"]) {
        self.mTopMargin.constant = -94;

    }else{
        self.mTopMargin.constant = -44;

        
    }

    
  const  NSString *mDeviceInfo = [[WKGetDeviceInfo sharedLibrery] getDiviceName];
    MLLog(@"设备信息：%@",mDeviceInfo);

    [NSNetworkMonitor registerNetworkNotification:self];
    _mNetWorkStatus = [NSNetworkMonitor currentNetworkStatusString];

//    self.d_navBarAlpha = 0;
    
    mTopBannerArr = [NSMutableArray new];
    mFuncArr = [NSMutableArray new];
    mJHBannerArr = [NSMutableArray new];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.tableView = self.mTableView;
    UINib   *nib = [UINib nibWithNibName:@"WKHomeTypeHeaderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"normalCell"];

    nib = [UINib nibWithNibName:@"WKHomeDecomandedCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"demandedCell"];

    nib = [UINib nibWithNibName:@"WKHomeActivityCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"activityCell"];

    
//    [self addTableViewHeaderRefreshing];
//    [self addTableViewFootererRefreshing];

    [self getUserInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getPushMessage)
                                                 name:KAppFetchJPUSHService
                                               object:nil];
    
    NSArray *mLArr = [MWLocationInfo bg_findAll];
    if (mLArr.count>0) {
        MWLocationInfo *mLocation = mLArr[0];
        NSMutableDictionary *para = [NSMutableDictionary new];
        if (mLocation.shi) {
            [para setObject:mLocation.shi forKey:@"city"];
        }
        if (mLocation.jing.length>0) {
            [para setObject:[NSString stringWithFormat:@"%@,%@",mLocation.wei,mLocation.jing] forKey:@"location"];

        }
        [MWBaiDuApiBaseObj WKGetBaiDuWeather:mLocation.shi andJingdu:nil andWeidu:nil block:^(MWBaiDuApiBaseObj *info) {
            if (info.status == 0) {
                
            }else{
                
            }
        }];
    }else{
        [self updateAddress];
    }
    
    
}
#pragma mark----****----获取定位信息
- (void)updateAddress{
    
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
    
}
#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
    
    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
    [MWLocationInfo bg_clear];
    MWLocationInfo *mLocation = [MWLocationInfo yy_modelWithDictionary:mCoordinate];
    [mLocation bg_save];
    
}
- (void)getUserInfo{

    if ([WKUser currentUser].member_id <= 0 ) {
        MLLog(@"用户信息:%@",[WKUser currentUser]);
        [self gotoLogin];

    }else{
        [self getPushMessage];

    }
   
}
- (void)getPushMessage{
    __weak __typeof(self)weakSelf = self;
    
    [self.tableView setRefreshWithHeaderBlock:^{
        [weakSelf tableViewHeaderReloadData];
    } footerBlock:^{
        [weakSelf tableViewFooterReloadData];
    }];
    
    [self.tableView setupEmptyData:^{
        [weakSelf tableViewHeaderReloadData];
        
    }];
    [self.tableView headerBeginRefreshing];

}
- (void)gotoLogin{
    WKGenericLoginViewController *vc = [WKGenericLoginViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.mLoginType = WKLogin;
    vc.mBlock = ^(NSInteger para) {
        if (para == 1) {
            [self addTableViewHeaderRefreshing];
            
        }
    };
    [self presentModalViewController:vc];
}
- (void)tableViewHeaderReloadData{
    [mTopBannerArr removeAllObjects];
    [mFuncArr removeAllObjects];
    [mJHBannerArr removeAllObjects];
    [mActArr removeAllObjects];

    [mRecommend removeAllObjects];
    NSArray *mFArr = @[@"icon_xiyiji",@"icon_jinbi"];
    NSArray *mTArr = @[@"洗衣机",@"金币充值"];

    for (int i=0; i<mFArr.count; i++) {
        WKFunc *mFC = [WKFunc new];
        mFC.mFuncName = mTArr[i];
        mFC.mFuncImg = mFArr[i];
        [mFuncArr addObject:mFC];

    }
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [WKHome WKGetHomeList:@{} block:^(MWBaseObj *info, NSArray *mBannerArr, NSArray *mTuijianArr, NSArray *mActivityArr,NSArray *mNoticeArr) {
        [SVProgressHUD dismiss];
        if (info.err_code == 0) {
            [mTopBannerArr addObjectsFromArray:mBannerArr];
            [mRecommend addObjectsFromArray:mTuijianArr];
            [mActArr addObjectsFromArray:mActivityArr];

            if (mNoticeArr.count>0) {
                mNoticeObj = mNoticeArr[0];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [self.tableView headerEndRefreshing];
        
        [self.tableView reloadData];
    }];
    
//    NSMutableDictionary *bannerpara = [NSMutableDictionary new];
//    [bannerpara setObject:kJUHEAPIKEY forKey:@"key"];
//    [bannerpara setObject:@"guonei" forKey:@"type"];
//    [SVProgressHUD showWithStatus:@"正在加载..."];
//    [WKNews WKGetJuheNewsList:bannerpara block:^(WKJUHEObj *info, NSArray *mArr) {
//
//        if (info.error_code == 0) {
//            [SVProgressHUD dismiss];
//            for (int i = 0; i<mArr.count; i++) {
//                WKNews *mNew = mArr[i];
//            [mTopBannerArr addObject:mNew.thumbnail_pic_s];
//                if (i==4) {
//                    break;
//                }
//            }
//            [mJHBannerArr addObjectsFromArray:mArr];
////            [self.tableView headerEndRefreshing];
////
//            [self.tableView headerEndRefreshing];
//
//            [self.tableView reloadData];
//
//        }else{
//            [SVProgressHUD showErrorWithStatus:info.reason];
//            [SVProgressHUD dismiss];
//
//
//        }
//
//    }];
//
//    NSMutableDictionary *mWechat = [NSMutableDictionary new];
//    [mWechat setObject:kMobTrainDemandKey forKey:@"key"];
//    [mWechat setObject:@"1" forKey:@"cid"];
//    [mWechat setObject:@"1" forKey:@"page"];
//    [mWechat setObject:@"4" forKey:@"size"];
//
//
//    [WKWechatObj WKGetWechat:mWechat block:^(WKBaseInfo *info, NSArray *mArr) {
//
//        if (info.status == 0) {
//            [SVProgressHUD dismiss];
//
//                [mRecommend addObjectsFromArray:mArr];
//
//            [self.tableView headerEndRefreshing];
//
//            [self.tableView reloadData];
//
//        }else{
//            [SVProgressHUD dismiss];
//        }
//
//    }];
//
//
//    NSMutableDictionary *mJunshi = [NSMutableDictionary new];
//    [mJunshi setObject:kJUHEAPIKEY forKey:@"key"];
//    [mJunshi setObject:@"junshi" forKey:@"type"];
//
//    [WKNews WKGetJuheNewsList:mJunshi block:^(WKJUHEObj *info, NSArray *mArr) {
//
//        if (info.error_code == 0) {
//            [SVProgressHUD dismiss];
//            for (int i = 0; i<mArr.count; i++) {
//                WKNews *mNew = mArr[i];
//                [mActArr addObject:mNew];
//                if (i==3) {
//                    break;
//                }
//            }
//            [self.tableView headerEndRefreshing];
//
//            [self.tableView reloadData];
//
//        }else{
//            [SVProgressHUD showErrorWithStatus:info.reason];
//
//            [SVProgressHUD dismiss];
//        }
//
//    }];

}
- (void)judgeString{
    
    BOOL mJ = [Util WKJudgeString:@"http://xxlaundry.aboutnew.net/qr/?q=eHgyMDE3MDkwNTAyNDUxNzYwNzM4NDA4" toString:@"eHgyMDE3MDkwNTAyNDUxNzYwNz"];
    if (mJ) {
        NSString *mCurrentString = [Util WK_StringToString:@"http://xxlaundry.aboutnew.net/qr/?qbarcode111222=eHgyMDE3MDkwNTAyNDUxNzYwNzg5NTMx" toString:@"eHgy"];
        [self showSucess:@"有"];
        MLLog(@"包含了：%@",mCurrentString);
        
    }else{
        [self showError:@"没有"];
        MLLog(@"不包含");

    }
}
- (void)tableViewFooterReloadData{
    [self.tableView footerEndRefreshing];

}
-(void)networkStatusChangeNotification:(NSNotification *)notification
{
    _mNetWorkStatus = [NSNetworkMonitor currentNetworkStatusString];
    MLLog(@"%@\n%@",_mNetWorkStatus,notification);
    
}

- (void)mAction{

    [self showCustomViewType:WKCustomPopViewHaveCloseBtn andTitle:@"这个是标题" andContentTx:@"这个是内容内容内容" andOkBtntitle:@"确定" andCancelBtntitle:@"取消"];

    
    
//    WKtrainDemandViewController *vc = [WKtrainDemandViewController new];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        //加载图片
//        NSLog(@"one");
//        [self.navigationController.navigationBar setHidden:NO];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            //加载完成更新view
//            NSLog(@"two");
//            [self.navigationController d_pushViewController:vc fromAlpha:self.d_navBarAlpha toAlpha:1];
//
//        });
//    });
    
}
- (void)WKCustomPopViewWithCloseBtnAction{
    
    MLLog(@"取消");
}
- (void)WKCustomPopViewWithOkBtnAction{
    
    
    MLLog(@"好的");
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
 
    return 3;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.5;
    }else{
        return 45;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
            return nil;
    }else if(section == 1){
        if (mRecommend.count<=0) {
            return nil;
        }else{
            mSectionView = [WKHomeHeaderSectionView initView];
            mSectionView.mTitle.text = @"- 推荐 -";
            mSectionView.mTitle.textColor = [UIColor colorWithRed:0.28 green:0.8 blue:0.29 alpha:1];
            return mSectionView;
        }
        
    }else{
        if (mActArr.count<=0) {
            return nil;
        }else{
            mSectionView = [WKHomeHeaderSectionView initView];
            mSectionView.mTitle.text = @"- 活动 -";
            mSectionView.mTitle.textColor = [UIColor colorWithRed:0.97 green:0.47 blue:0.11 alpha:1];
            return mSectionView;
        }

    }
        
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return mRecommend.count%2==0?mRecommend.count/2:mRecommend.count/2+1;
        
    }else{
        return mActArr.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 330;
    }else if(indexPath.section == 1){
        return 80;
    }else{
        return 150;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"normalCell";
        
        WKHomeTypeHeaderCell  *cell = [[WKHomeTypeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mTopBannerArr andDataSource:mFuncArr andScrollerLabelTx:[NSString stringWithFormat:@"%@            ",mNoticeObj.content]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        
        return cell;
    }else if(indexPath.section == 1){
        reuseCellId = @"demandedCell";
        
        WKHomeDecomandedCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        
        WKHome *mN1 = mRecommend[indexPath.row*2];
        WKHome *mN2;
        if ((indexPath.row+1)*2>mRecommend.count) {
            cell.mrightImg.hidden = YES;
            cell.mIndex = indexPath.row*2;

        }else{
            mN2 = mRecommend[indexPath.row*2+1];
            cell.mrightImg.hidden = NO;
            cell.mRIndex = indexPath.row*2+1;

        }
        [cell.mLeftImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mN1.banner_img]] placeholderImage:nil];
        [cell.mrightImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mN2.banner_img]] placeholderImage:nil];
        
        
        return cell;
    }else{
    
        reuseCellId = @"activityCell";
        
        WKHomeActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        WKHome *mN = mActArr[indexPath.row];

        [cell.mImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mN.banner_img]] placeholderImage:nil];
        return cell;

    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        MLLog(@"%ld行",indexPath.row);
        

        WKHome *mN = mActArr[indexPath.row];
        if (mN.banner_skip_content.length>0 || mN.banner_skip_content !=nil) {
            WKWebViewController *vc = [WKWebViewController new];
            vc.mURLString = mN.banner_skip_content;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
       
    }
    
}
///左边按钮的代理方法
- (void)WKHomeDecomandedCellDelegateWithLeftBtnClicked:(NSInteger)mIndex{
    WKHome *mN = mRecommend[mIndex];
    if (mN.banner_skip_content.length>0 || mN.banner_skip_content !=nil) {
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = mN.banner_skip_content;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
////右边按钮的代理方法
- (void)WKHomeDecomandedCellDelegateWithRightBtnClicked:(NSInteger)mIndex{
    WKHome *mN = mRecommend[mIndex];
    if (mN.banner_skip_content.length>0 || mN.banner_skip_content !=nil) {
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = mN.banner_skip_content;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

}
#pragma mark----****----跑马灯+语音播放
/**
 跑马灯点击的代理方法
 */
- (void)WKHomeScrollerLabelDidSelected{
    MLLog(@"跑马灯");
    
    WKWebViewController *vc = [WKWebViewController new];
    vc.mURLString = @"http://cq.189.cn/cms/picAdv.htm?id=21329?gzh-cqwt";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}
/**
 主功能按钮点击的代理方法
 
 @param mIndex 索引
 */
- (void)WKHomeScrollerTableViewCellDidSelectedWithIndex:(NSInteger)mIndex{
    MLLog(@"%ld",mIndex);
    if (mIndex == 0) {
        WKWashViewController *vc = [WKWashViewController new];
        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (mIndex == 1){
        WKBuyGoldenViewController *vc = [WKBuyGoldenViewController new];
        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
        [self.navigationController pushViewController:vc animated:YES];
       
    }else if (mIndex == 2){
        WKBuyGoldenViewController *vc = [WKBuyGoldenViewController new];
        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        WKVipTopupViewController *vc = [WKVipTopupViewController new];
        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
        [self.navigationController pushViewController:vc animated:YES];

    }
}

/**
 点击baner的代理方法
 
 @param mIndex 索引
 */
- (void)WKHomeBannerDidSelectedWithIndex:(NSInteger)mIndex{
 
//    [WKProgressView WKShowView:self.view andStatus:WKProgressError WithTitle:@"成功" andContent:@"这是什么？" andBtnTitle:@"重新加载" andImgSRC:@"icon_paysucess" andBlock:^(WKProgressView *progressView, NSInteger btnIndex) {
//        MLLog(@"%ld",btnIndex);
//
//    }];

    WKHome *mNew = mTopBannerArr[mIndex];
    if (mNew.banner_skip_content.length>0 || mNew.banner_skip_content !=nil) {
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = mNew.banner_skip_content;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }


}


@end
