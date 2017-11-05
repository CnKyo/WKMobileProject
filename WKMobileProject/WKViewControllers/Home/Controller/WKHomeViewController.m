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

@interface WKHomeViewController ()<WKHomeTypeHeaderCellDelegate,WKHomeDecomandedCellDelegate,NSNetworkMonitorProtocol>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTopMargin;


///网络状态 
@property (strong,nonatomic) NSString *mNetWorkStatus;

@end

@implementation WKHomeViewController{

    ///banner数据源
    NSMutableArray *mBannerArr;
    NSMutableArray *mFuncArr;

    ///列表分组viewinf
    WKHomeHeaderSectionView *mSectionView;
    
    

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
    
    
    UIImage *image = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = image;
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.96 green:0.43 blue:0.01 alpha:1]} forState:UIControlStateSelected];
    
    if (SystemIsiOS11()) {
        self.mTopMargin.constant = -94;
    }else{
        self.mTopMargin.constant = -44;
    }
    
  const  NSString *mDeviceInfo = [[WKGetDeviceInfo sharedLibrery] getDiviceName];
    MLLog(@"设备信息：%@",mDeviceInfo);

    [NSNetworkMonitor registerNetworkNotification:self];
    _mNetWorkStatus = [NSNetworkMonitor currentNetworkStatusString];

    self.d_navBarAlpha = 0;
    
    mBannerArr = [NSMutableArray new];
    mFuncArr = [NSMutableArray new];
    
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
- (void)tableViewHeaderReloadData{
    [mBannerArr removeAllObjects];
    [mFuncArr removeAllObjects];
    NSArray *mArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1493199772&di=66346cd79eed9c8cb4ec03c3734d0b31&src=http://img15.3lian.com/2015/f2/128/d/123.jpg",@"http://wmtp.net/wp-content/uploads/2017/04/0420_sweet945_1.jpeg",@"http://wmtp.net/wp-content/uploads/2017/04/0407_shouhui_1.jpeg"];
    NSArray *mFArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1493199772&di=66346cd79eed9c8cb4ec03c3734d0b31&src=http://img15.3lian.com/2015/f2/128/d/123.jpg"];
    NSArray *mTArr = @[@"洗衣机",@"金币充值"];

    for (int i=0; i<mFArr.count; i++) {
        WKFunc *mFC = [WKFunc new];
        mFC.mFuncName = mTArr[i];
        mFC.mFuncImg = mFArr[i];
        [mFuncArr addObject:mFC];

    }
    [mBannerArr addObjectsFromArray:mArr];

    [self.tableView headerEndRefreshing];
    
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
    [self judgeString];
    
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
    
        mSectionView = [WKHomeHeaderSectionView initView];
        mSectionView.mTitle.text = @"- 推荐 -";
        mSectionView.mTitle.textColor = [UIColor colorWithRed:0.28 green:0.8 blue:0.29 alpha:1];
        return mSectionView;
    }else{
        mSectionView = [WKHomeHeaderSectionView initView];
        mSectionView.mTitle.text = @"- 活动 -";
        mSectionView.mTitle.textColor = [UIColor colorWithRed:0.97 green:0.47 blue:0.11 alpha:1];
        return mSectionView;
    }
        
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 4;
    }else{
        return 4;
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
        
        WKHomeTypeHeaderCell  *cell = [[WKHomeTypeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mBannerArr andDataSource:mFuncArr andScrollerLabelTx:[NSString stringWithFormat:@"%@            ",@"这是跑马风这是跑马风这是跑马风这是跑马风"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        
        return cell;
    }else if(indexPath.section == 1){
        reuseCellId = @"demandedCell";
        
        WKHomeDecomandedCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        
        return cell;
    }else{
    
        reuseCellId = @"activityCell";
        
        WKHomeActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        return cell;

    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        MLLog(@"%ld行",indexPath.row);
        
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
    
}
#pragma mark----****----跑马灯+语音播放
/**
 跑马灯点击的代理方法
 */
- (void)WKHomeScrollerLabelDidSelected{
    MLLog(@"跑马灯");
    

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
        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
    }
    else if (mIndex == 1){
        WKBuyGoldenViewController *vc = [WKBuyGoldenViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
       ;
    }else if (mIndex == 2){
        WKBuyGoldenViewController *vc = [WKBuyGoldenViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];
    }else{
        WKVipTopupViewController *vc = [WKVipTopupViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];

    }
}

/**
 点击baner的代理方法
 
 @param mIndex 索引
 */
- (void)WKHomeBannerDidSelectedWithIndex:(NSInteger)mIndex{
//    MLLog(@"%ld",mIndex);
//    WKWebViewController *vc = [WKWebViewController new];
//    vc.mTitle = @"测试页面";
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController d_pushViewController:vc fromAlpha:0 toAlpha:1];

 
    [WKProgressView WKShowView:self.view andStatus:WKProgressError WithTitle:@"成功" andContent:@"这是什么？" andBtnTitle:@"重新加载" andImgSRC:@"icon_paysucess" andBlock:^(WKProgressView *progressView, NSInteger btnIndex) {
        MLLog(@"%ld",btnIndex);

    }];
    
}


@end
