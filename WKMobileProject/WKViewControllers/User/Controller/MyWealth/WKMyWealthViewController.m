//
//  WKMyWealthViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyWealthViewController.h"
#import "WKMyWealthTableViewCell.h"
#import "WKFetchWealthCell.h"
#import "WKMyWealthRecordViewController.h"
#import "WKBoundleToolViewController.h"
#import "WKRecordViewController.h"
@interface WKMyWealthViewController ()<WKMyWealthTableViewCellDelegate>

@end

@implementation WKMyWealthViewController
{
    UITableView *mTableView;
    
    MWMyRewardsObj *mRewards;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarHairlineImageView.hidden = YES;
    
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的财富值";
    self.view.backgroundColor = M_CO;
    mRewards = [MWMyRewardsObj new];
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    UIView *mView = [UIView new];
    mView.backgroundColor = M_CO;
    [self.view addSubview:mView];
    mTableView = [UITableView new];
    
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    
    self.tableView = mTableView;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WKMyWealthTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WKFetchWealthCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(54);
        make.height.offset(15);
        make.bottom.equalTo(mTableView.mas_top);
    }];
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(mView.mas_bottom);
    }];
    
    [self addRightBtn:YES andTitel:@"财富记录" andImage:nil];
    
    [self addTableViewHeaderRefreshing];
    //    [self addTableViewFootererRefreshing];
}
- (void)rightBtnAction{
    MLLog(@"财富记录");
    WKMyWealthRecordViewController *vc = [WKMyWealthRecordViewController new];
    [self pushViewController:vc];
}
- (void)tableViewHeaderReloadData{
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    [self.tableArr removeAllObjects];
    
    [MWBaseObj MWGetMyWealth:@{@"member_id":[WKUser currentUser].member_id} block:^(MWBaseObj *info, MWMyRewardsObj *mRewardsObj) {
        if (info.err_code == 0) {
            
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            mRewards = mRewardsObj;
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [self.tableView reloadData];
        
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        return 1;
    }else{
        return 10;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WKMyWealthTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        [cell setMMyRewards:mRewards];
        return cell;
    }else{
        WKFetchWealthCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 400;
    }else{
        return 85;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 45;
    }
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        UIView *_mHeaderView = [UIView new];
        _mHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
        _mHeaderView.backgroundColor = [UIColor colorWithRed:0.956862745098039 green:0.972549019607843 blue:0.996078431372549 alpha:1.00];
        
        UILabel *mLb = [UILabel new];
        mLb.text = @"- 获取财富 -";
        mLb.textColor = [UIColor blackColor];
        mLb.font = [UIFont systemFontOfSize:14];
        mLb.textAlignment = NSTextAlignmentCenter;
        mLb.frame = _mHeaderView.bounds;
        [_mHeaderView addSubview:mLb];
        return _mHeaderView;
    }
    
}
/**
 按钮点击代理事件
 
 @param mTag 返回按钮tag(0说明，1绑定，2提现 )
 */
- (void)WKMyWealthTableViewCellBtnClickedWithTag:(NSInteger)mTag{
    switch (mTag) {
        case 0:
        {
        MLLog(@"说明");
        WKMyWealthRecordViewController *vc = [WKMyWealthRecordViewController new];
        [self pushViewController:vc];
        }
            break;
        case 1:
        {
        MLLog(@"绑定首款工具");
        
        if ([WKUser currentUser].pay_type.length==0 || [[WKUser currentUser].pay_type isEqualToString:@"0"]) {
            WKBoundleToolViewController *vc= [WKBoundleToolViewController new];
            [self pushViewController:vc];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"您已绑定了收款工具，无需重复绑定！"];
            
        }
        }
            break;
        case 2:
        {
        MLLog(@"提现");
        if ([WKUser currentUser].pay_type.length==0 || [[WKUser currentUser].pay_type isEqualToString:@"0"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您还未绑定受款工具哦！" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"去绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                WKBoundleToolViewController *vc= [WKBoundleToolViewController new];
                [self pushViewController:vc];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            
            [alert addAction:ok];
            [alert addAction:cancel];
            
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            WKRecordViewController *vc = [WKRecordViewController new];
            [self pushViewController:vc];
        }
        
        
        }
            break;
            
        default:
            break;
    }
}
@end
