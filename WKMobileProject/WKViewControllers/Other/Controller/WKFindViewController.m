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
- (void)tableViewHeaderReloadData{
    [self.tableArr removeAllObjects];
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:kJUHEAPIKEY forKey:@"key"];
    [para setObject:@"keji" forKey:@"type"];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [WKNews WKGetJuheNewsList:para block:^(WKJUHEObj *info, NSArray *mArr) {
        
        if (info.error_code == 0) {
            [SVProgressHUD dismiss];
            [self.tableArr addObjectsFromArray:mArr];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD dismiss];
            
        }
        [self.tableView headerEndRefreshing];
        
    }];
    
    
    NSArray *mArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1493199772&di=66346cd79eed9c8cb4ec03c3734d0b31&src=http://img15.3lian.com/2015/f2/128/d/123.jpg",@"http://wmtp.net/wp-content/uploads/2017/04/0420_sweet945_1.jpeg",@"http://wmtp.net/wp-content/uploads/2017/04/0407_shouhui_1.jpeg"];
    [mBannerArr addObjectsFromArray:mArr];
    
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
    
}

/**
 功能按钮点击代理方法
 
 @param mIndex 返回索引
 */
- (void)WKFindHeaderCellDelegateWithFuncClicked:(NSInteger)mIndex{
    MLLog(@"%ld",mIndex);
    if (mIndex == 0) {
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        WKPlayGameViewController *vc = [story instantiateViewControllerWithIdentifier:@"playGame"];
        vc.hidesBottomBarWhenPushed = YES;
        //        [self pushViewController:vc];
        [self.navigationController pushViewController:vc animated:YES];
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
