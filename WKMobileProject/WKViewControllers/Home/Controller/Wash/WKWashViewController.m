//
//  WKWashViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashViewController.h"
#import "WKWashHeaderView.h"
#import "WKWashTableHeaderView.h"
#import "WKWashTableCell.h"

#import "WKWashBookingViewController.h"
#import "WKMyWashBookingViewController.h"
#import "WKScanDeviceViewController.h"

#import "WKQuikWashViewController.h"
@interface WKWashViewController ()<WKWashTableHeaderViewDelegate,WKWashHeaderViewDelegate>
{
    BOOL  Display[100];

}
    
@property (nonatomic,strong)NSMutableArray *mTitleArr;
@property (nonatomic,strong)NSMutableArray *mSubTitleArr;
@property (nonatomic,strong)NSMutableArray *mContentArr;

@property(nonatomic,strong)NSMutableDictionary * dic;
@property(nonatomic,strong)WKWashTableHeaderView *mHeaderView;
@end

@implementation WKWashViewController
{
    WKWashHeaderView *mHeaderView;
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
    self.navigationItem.title = @"洗衣机";
    
    self.mTitleArr = [NSMutableArray new];
    self.mSubTitleArr = [NSMutableArray new];
    self.mContentArr = [NSMutableArray new];

    self.dic = [[NSMutableDictionary alloc]init];

    self.view.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    
    mHeaderView = [WKWashHeaderView initView];
//    mHeaderView.frame = CGRectMake(0, 61, DEVICE_Width, 150);
    mHeaderView.delegate = self;
    [self.view addSubview:mHeaderView];
    
    [mHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.offset(150);
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
    [self.tableView registerNib:[UINib nibWithNibName:@"WKWashTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self addTableViewHeaderRefreshing];
//    [self addTableViewFootererRefreshing];
}
- (void)WKWashHeaderViewBtnAction:(NSInteger)mTag{
    switch (mTag) {
        case 1:
        {
        MLLog(@"我要预约");
        
        WKWashBookingViewController *vc = [WKWashBookingViewController new];
        [self pushViewController:vc];

       
        }
            break;
        case 2:
        {
        MLLog(@"我的预约");
        WKMyWashBookingViewController *vc = [WKMyWashBookingViewController new];
        [self pushViewController:vc];
        }
            break;
        case 3:
        {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WKScanDeviceViewController *vc = [board instantiateViewControllerWithIdentifier:@"scan"];;
        [self pushViewController:vc];
//        WKQuikWashViewController *vc = [WKQuikWashViewController new];
//        [self pushViewController:vc];
        MLLog(@"立即使用");
        }
            break;
            
        default:
            break;
    }
}
- (void)tableViewHeaderReloadData{
  
    [self.mTitleArr removeAllObjects];
    [self.mSubTitleArr removeAllObjects];
    [self.mContentArr removeAllObjects];

    [SVProgressHUD showWithStatus:@"加载中..."];
    [MWBaseObj MWGetWashNoteContent:^(MWBaseObj *info,NSArray *mTArr,NSArray *mSTArr,NSArray *mCArr) {
        if(info.err_code == 0){
            [self.mTitleArr addObjectsFromArray:mTArr];
            [self.mSubTitleArr addObjectsFromArray:mSTArr];
            [self.mContentArr addObjectsFromArray:mCArr];
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [self.tableView reloadData];

        [SVProgressHUD dismiss];
    }];
    
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.mTitleArr.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (Display[section] == YES)
        {
        NSLog(@"section----%ld",(long)section);
        return 1;
        }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKWashTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.mContent.text = self.mContentArr[indexPath.section];
//    if (indexPath.section == 0)
//        {
//
//        cell.mContent.text = self.mSubTitleArr[0];
//
//        } if (indexPath.section == 1)
//            {
//            cell.mContent.text = self.mSubTitleArr[1];
//            }
//    if (indexPath.section == 2)
//        {
//        cell.mContent.text = self.mSubTitleArr[2];
//        }
//    if (indexPath.section == 3)
//        {
//        cell.mContent.text = self.mSubTitleArr[3];
//        }
//
//    if (indexPath.section == 4)
//        {
//        cell.mContent.text = self.mSubTitleArr[4];
//        }
//    if (indexPath.section == 5)
//        {
//        cell.mContent.text = self.mSubTitleArr[5];
//        }
//
//
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 90;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _mHeaderView = [WKWashTableHeaderView initView];
    _mHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 90);
    _mHeaderView.mContent.text = self.mSubTitleArr[section];
    _mHeaderView.mTitle.text = self.mTitleArr[section];
    _mHeaderView.mIndexPath = section;
    _mHeaderView.delegate = self;
    
    NSString *mT = Display[section]?@"收起":@"展开";
    UIImage *mImg = Display[section]?[UIImage imageNamed:@"icon_up"]:[UIImage imageNamed:@"icon_down"];
    [_mHeaderView.mExtBtn setImage:mImg forState:0];
    [_mHeaderView.mExtBtn setTitle:mT forState:0];
    [_mHeaderView.mExtBtn setTitleColor:[UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1] forState:0];
    
    
    return _mHeaderView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)WKWashHeaderExtBtnAction:(NSInteger)mIndexPath{
    Display[mIndexPath] = !Display[mIndexPath];
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:mIndexPath];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];

}

@end
