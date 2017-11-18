//
//  WKOtherViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKFindViewController.h"
#import "WKFindTableViewCell.h"
#import "WKFindHeaderCell.h"
#import "WKPlayGameViewController.h"

#import "UIScrollView+DREmptyDataSet.h"
#import "UIScrollView+DRRefresh.h"

#import "WKWebViewController.h"

#import "NNDeviceInformation.h"

#import "FCIPAddressGeocoder.h"
#import "GetIPAddress.h"

#import "OnlyLocationManager.h"
#import "CurentLocation.h"

@interface WKFindViewController ()<WKFindHeaderCellDelegate,UITableViewDataSource,UITableViewDelegate,MMApBlockCoordinate>

@end

@implementation WKFindViewController
{
    
    UILabel *mHeaderMessage;
    
    NSMutableArray *mBannerList;
    
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
    self.navigationItem.title = @"发现";
    [self updateAddress];

    self.tableArr = [NSMutableArray new];
    mBannerList = [NSMutableArray new];
    self.view.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    mHeaderMessage = [UILabel new];
    mHeaderMessage.backgroundColor = M_BCO;
    mHeaderMessage.frame = CGRectMake(0, 0, DEVICE_Width, 45);
    mHeaderMessage.text = @"正在获取天气信息...";
    mHeaderMessage.font = [UIFont systemFontOfSize:15];
    mHeaderMessage.textColor = [UIColor whiteColor];
    mHeaderMessage.textAlignment = NSTextAlignmentCenter;
    
    self.tableView.tableHeaderView = mHeaderMessage;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"WKFindTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    nib = [UINib nibWithNibName:@"WKFindHeaderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    
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
    
    [self updateAddress];
    
}
#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
}
- (void)loadWeather{
    MLLog(@"定位信息：%@",[MWLocationInfo currentLocationInfo].latitude);
    if ([MWLocationInfo currentLocationInfo].latitude.length ==  0) {
        [self updateAddress];
        
    }else{
        [WKJUHEObj MWGetAFanDaWeather:@{@"key":kAFanDaAppKey,@"cityname":[MWLocationInfo currentLocationInfo].city} block:^(WKJUHEObj *info,MWWeatherObj *mWeather) {
            if (info.error_code == 0) {
                mHeaderMessage.text = [NSString stringWithFormat:@"%@度 : %@  : %@",mWeather.weather.temperature,mWeather.weather.info,mWeather.city_name];
            }else{
                mHeaderMessage.text = @"获取天气失败，请重新打开定位后再试！";

            }
        }];
    }
}
#pragma mark----****----获取定位信息
- (void)updateAddress{
    
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
    
    [OnlyLocationManager shareManager:NO needVO:YES initCallBack:^(LocationInitType type, CLLocationManager *manager) {
        
    } resultCallBack:^(CLLocationCoordinate2D coordinate, CLLocation *location, OnlyLocationVO *locationVO) {
        [self locationSuccess:locationVO];
    }];
    
}
-(void)locationSuccess:(OnlyLocationVO *)locationVO{
    [MWLocationInfo bg_clear];
    MWLocationInfo *mLocationInfo = [MWLocationInfo new];
    mLocationInfo.district = locationVO.addressComponent.district;
    mLocationInfo.city = locationVO.addressComponent.city;
    mLocationInfo.country = locationVO.addressComponent.country;
    mLocationInfo.adcode = locationVO.addressComponent.adcode;
    mLocationInfo.street = locationVO.addressComponent.street;
    mLocationInfo.distance = locationVO.addressComponent.distance;
    mLocationInfo.street_number = locationVO.addressComponent.street_number;
    mLocationInfo.country_code = locationVO.addressComponent.country_code;
    mLocationInfo.direction = locationVO.addressComponent.direction;
    mLocationInfo.province = locationVO.addressComponent.province;
    
    mLocationInfo.latitude = [NSString stringWithFormat:@"%f",locationVO.location.latitude];
    mLocationInfo.longitude = [NSString stringWithFormat:@"%f",locationVO.location.longitude];
    
    [mLocationInfo bg_save];
    
    
}
-(void)locationStateChange:(NSNotification* )noti{
    OnlyLocationManager* manager = [OnlyLocationManager getLocationManager];
    NSLog(@"%ld",manager.state);
    
    NSString* stateStr = @"初始化";
    switch (manager.state) {
        case 0:
            stateStr = @"初始化失败";
            break;
        case 1:
            stateStr = @"定位中";
            break;
        case 2:
            stateStr = @"已获取初始位置并持续定位中";
            break;
        case 3:
            stateStr = @"已定位，正在逆地理编码";
            break;
        case 4:
            stateStr = @"已定位，逆地理编码完成";
            break;
        case 5:
            stateStr = @"已定位，逆地理编码失败";
            break;
    }
    
    NSLog(@"%@",stateStr);
    self.title = stateStr;
}

- (void)tableViewHeaderReloadData{
    [self loadWeather];

    [mBannerList removeAllObjects];
    [self.tableArr removeAllObjects];
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [MWBaseObj MWGetFindList:@{} block:^(MWBaseObj *info, NSArray *mBannerArr, NSArray *mList) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [mBannerList addObjectsFromArray:mBannerArr];
            [self.tableArr addObjectsFromArray:mList];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [self.tableView headerEndRefreshing];
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
    
    if (section == 0) {
        return 0;
    }else{
        return 10;
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
    }else{
        return self.tableArr.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 255;
    }else{
        return 100;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"cell2";
        
        
        WKFindHeaderCell *cell = [[WKFindHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mBannerList andDataSource:self.tableArr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else{
        
        reuseCellId = @"cell";
        
        WKFindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        [cell setMNews:self.tableArr[indexPath.row]];
        return cell;
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        MLLog(@"%ld行",indexPath.row);
        
        MWDiscoveryObj *mNew = self.tableArr[indexPath.row];
        if ([Util isUrl:mNew.func_skip_content]) {
            WKWebViewController *vc = [WKWebViewController new];

            vc.mURLString = mNew.func_skip_content;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        

    }
    
}


/**
 banner点击代理方法
 
 @param mIndex 返回索引
 */
- (void)WKFindHeaderCellDelegateWithBannerClicked:(NSInteger)mIndex{
    MLLog(@"%ld",mIndex);
    
    WKHome *mNew = mBannerList[mIndex];
    if ([Util isUrl:mNew.banner_skip_content]) {
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = mNew.banner_skip_content;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

/**
 功能按钮点击代理方法
 
 @param mIndex 返回索引  1:玩游戏。2:看直播。3:笑一笑。 4:读小说
 */
- (void)WKFindHeaderCellDelegateWithFuncClicked:(NSInteger)mIndex{
    MLLog(@"%ld",mIndex);
//    if (mIndex == 0) {
//
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//        WKPlayGameViewController *vc = [story instantiateViewControllerWithIdentifier:@"playGame"];
//        vc.hidesBottomBarWhenPushed = YES;
//        //        [self pushViewController:vc];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    switch (mIndex) {
        case 0:
        {
//        WKWebViewController *vc = [WKWebViewController new];
//        vc.mURLString = @"http://h5.265g.com/?mid=15";
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        WKPlayGameViewController *vc = [story instantiateViewControllerWithIdentifier:@"playGame"];
        vc.hidesBottomBarWhenPushed = YES;
        //        [self pushViewController:vc];
        [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = @"https://www.douyu.com/";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = @"http://www.hao123.com/gaoxiao";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        }
            break;
        case 3:
        {
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = @"http://hao123.zongheng.com/store/c2/w0/s0/p1/all.html";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
/**
 搜索框文本代理方法
 
 @param mText 返回输入文本内容
 */
- (void)WKFindHeaderCellDelegateWithSearchText:(NSString *)mText{
    MLLog(@"输入的内容是：%@",mText);
}
///搜索按钮代理方法
- (void)WKFindHeaderCellDelegateWithSearchBtnClicked{
    MLLog(@"搜索");
    
}

@end
