//
//  WaskBookingResultController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WaskBookingResultController.h"
#import "WKWashBookingHeaderView.h"
#import "WKWashBookingCell.h"
#import "WKHeader.h"
#import "WKWashGoPayViewController.h"
@interface WaskBookingResultController ()<WKWashBookingCellDelegate>

@end

@implementation WaskBookingResultController{
    WKWashBookingHeaderView *mHeaderView;
    UITableView *mTableView;

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
    self.navigationItem.title = @"预约结果";
    
    self.view.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    // Do any additional setup after loading the view.
    mHeaderView = [WKWashBookingHeaderView initBookingView];
    //    mHeaderView.frame = CGRectMake(0, 61, DEVICE_Width, 150);
    [self.view addSubview:mHeaderView];
    
    [mHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.offset(240);
    }];
    
    mTableView = [UITableView new];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mHeaderView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView = mTableView;
    self.tableView.estimatedRowHeight= 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"WKBookingResultCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
//    [self addTableViewHeaderRefreshing];
//    [self addTableViewFootererRefreshing];
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
    
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKWashBookingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *mView = [UIView new];
    mView.backgroundColor = [UIColor whiteColor];
    
    UIButton *mOkBtn = [UIButton new];
    mOkBtn.frame = CGRectMake(100, 15, DEVICE_Width-200, 45);
    mOkBtn.backgroundColor = [UIColor colorWithRed:0.968627450980392 green:0.580392156862745 blue:0.270588235294118 alpha:1.00];
    [mOkBtn setTitle:@"付款" forState:0];
    [mOkBtn addTarget:self action:@selector(mPayAction) forControlEvents:UIControlEventTouchUpInside];
    [mView addSubview:mOkBtn];

    [mOkBtn setButtonRoundedCornersWithView:mView andCorners:UIRectCornerAllCorners radius:3.0];
    return mView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
- (void)mPayAction{
    MLLog(@"付款");
    WKWashGoPayViewController *vc = [WKWashGoPayViewController new];
    [self pushViewController:vc];
}
- (void)WKWashBookingCellBtnAction:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了%ld行",mIndexPath.row);

}

@end
