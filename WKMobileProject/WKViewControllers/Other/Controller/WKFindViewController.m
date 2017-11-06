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

@interface WKFindViewController ()<WKFindHeaderCellDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation WKFindViewController
{
    
    UILabel *mHeaderMessage;
    
    NSMutableArray *mBannerArr;
    
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
    
    self.tableArr = [NSMutableArray new];
    mBannerArr = [NSMutableArray new];
    self.view.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    mHeaderMessage = [UILabel new];
    mHeaderMessage.backgroundColor = M_BCO;
    mHeaderMessage.frame = CGRectMake(0, 0, DEVICE_Width, 45);
    mHeaderMessage.text = @"重庆-多云  31-35度";
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
    
    
}
//- (void)updateAddress{
//
//    [FCIPAddressGeocoder setDefaultService:FCIPAddressGeocoderServiceFreeGeoIP];
//    //你可以使用共享实例
//    //或者创建一个新的geocoder，它使用安装在你自己的服务器上的FreeGeoIP服务的自定义实例
//    FCIPAddressGeocoder * geocoder = [[FCIPAddressGeocoder alloc ] initWithService:FCIPAddressGeocoderServiceFreeGeoIP andURL:[NNDeviceInformation getDeviceIPAdress]];
//    geocoder.canUseOtherServicesAsFallback = YES;
//    [geocoder geocode:^(BOOL success) {
//        if (success == YES) {
//            geocoder.location.coordinate;
//        }else{
//
//        }
//    }];
//    [geocoder isGeocoding];
//
//}
- (void)tableViewHeaderReloadData{
    

    [SVProgressHUD showWithStatus:@"正在加载..."];
    dispatch_async(dispatch_get_main_queue(), ^{
        MLLog(@"=== 执行A ===");
        [self.tableArr removeAllObjects];

        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:kJUHEAPIKEY forKey:@"key"];
        [para setObject:@"keji" forKey:@"type"];
        
        [WKNews WKGetJuheNewsList:para block:^(WKJUHEObj *info, NSArray *mArr) {
            
            if (info.error_code == 0) {
                [SVProgressHUD dismiss];
                [self.tableArr addObjectsFromArray:mArr];
                [self.tableView reloadData];

            }else{
                [SVProgressHUD dismiss];
                
            }
            
        }];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        MLLog(@"=== 执行B ===");
        NSMutableDictionary *weather = [NSMutableDictionary new];
        [weather setObject:kMobTrainDemandKey forKey:@"key"];
        [weather setObject:[GetIPAddress getIPAddress:YES] forKey:@"ip"];
        [weather setObject:@"" forKey:@"province"];
        [WKNews WKGetWeather:weather block:^(WKBaseInfo *info) {
            if (info.status == kRetCodeSucess) {
                
            }else{
                
            }
        }];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        MLLog(@"=== 执行C ===");
        [mBannerArr removeAllObjects];

        NSMutableDictionary *bannerpara = [NSMutableDictionary new];
        [bannerpara setObject:kJUHEAPIKEY forKey:@"key"];
        [bannerpara setObject:@"shehui" forKey:@"type"];
        

        [WKNews WKGetJuheNewsList:bannerpara block:^(WKJUHEObj *info, NSArray *mArr) {
            
            if (info.error_code == 0) {
                [SVProgressHUD dismiss];
                [mBannerArr addObjectsFromArray:mArr];
                [self.tableView reloadData];

            }else{
                [SVProgressHUD dismiss];
                
            }
            
        }];
    });
    dispatch_group_t group = dispatch_group_create();
    
    // 这里执行三次
    dispatch_queue_t aaa = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(aaa,^{
        
        dispatch_group_leave(group);
        NSLog(@"=== 任务 1 完成 ===");

        
    });
    dispatch_queue_t bbb = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(bbb,^{
        
        dispatch_group_leave(group);
        NSLog(@"=== 任务 2 完成 ===");

        
    });
    
    dispatch_queue_t ccc = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(ccc,^{
        
        dispatch_group_leave(group);
        NSLog(@"=== 任务 3 完成 ===");

    });
    // 三次结束
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"=== 任务 M 完成 ===");
        [self.tableView headerEndRefreshing];
        [SVProgressHUD dismiss];

        
    });
    
    
    
    
    
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
        
        
        WKFindHeaderCell *cell = [[WKFindHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mBannerArr andDataSource:self.tableArr];
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
        
        WKNews *mNew = self.tableArr[indexPath.row];
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = mNew.url;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


/**
 banner点击代理方法
 
 @param mIndex 返回索引
 */
- (void)WKFindHeaderCellDelegateWithBannerClicked:(NSInteger)mIndex{
    MLLog(@"%ld",mIndex);
    //    NSMutableArray *mImgUrl = [NSMutableArray new];
    //    for (int i = 0;i<mBannerArr.count;i++) {
    //        WKNews *mNew = mBannerArr[i];
    //        [mImgUrl addObject:mNew];
    //        if (i==4) {
    //            break;
    //        }
    //
    //    }
    
    WKNews *mNew = mBannerArr[mIndex];
    WKWebViewController *vc = [WKWebViewController new];
    vc.mURLString = mNew.url;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
        WKWebViewController *vc = [WKWebViewController new];
        vc.mURLString = @"http://h5.265g.com/?mid=15";
        vc.hidesBottomBarWhenPushed = YES;
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
