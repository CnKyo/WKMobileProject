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
#import "WKChoiceWashTableViewCell.h"

#define defaultTag 0

@interface WaskBookingResultController ()<WKWashBookingCellDelegate>
@property (nonatomic, assign) NSInteger btnTag;//默认选中的Tag

@end

@implementation WaskBookingResultController{
    WKWashBookingHeaderView *mHeaderView;
    UITableView *mTableView;
    NSString *mWashID;
    
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
    
    self.btnTag = defaultTag; //self.btnTag = defaultTag+1  表示默认选择第二个，依次类推
    
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    // Do any additional setup after loading the view.
    mHeaderView = [WKWashBookingHeaderView initBookingView];
    //    mHeaderView.frame = CGRectMake(0, 61, DEVICE_Width, 150);
    mHeaderView.mWashAddress.text = [NSString stringWithFormat:@"洗衣机位置：%@",_mDeviceInfo.device_address];
    if ([_mDeviceInfo.device_status isEqualToString:@"1"]) {
        mHeaderView.mWashStatus.text = @"洗衣机状态：工作中";
    } else {
        mHeaderView.mWashStatus.text = @"洗衣机状态:空闲";
    }
    mHeaderView.mWashSeclected.hidden = YES;
    
    mHeaderView.mCountTime.textColor = [UIColor whiteColor];
    MZTimerLabel *mC  = [[MZTimerLabel alloc] initWithLabel:mHeaderView.mCountTime andTimerType:MZTimerLabelTypeTimer];
    [mC setCountDownTime:15*60]; //** Or you can use [timer3 setCountDownToDate:aDate];
    [mC start];
    [self.view addSubview:mHeaderView];
    
    [mHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.offset(260);
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
    [self bookingResult];
}
- (void)bookingResult{
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    if (_mType == 1) {
        
        [para setObject:_mCode forKey:@"device_barcode"];
    }else{
        [para setObject:_mDeviceInfo.wash_id forKey:@"wash_id"];
        
    }
    [self.tableArr removeAllObjects];
    
    if ([WKUser currentUser].member_id.length>0) {
        
        MLLog(@"参数是：%@",para);
        
        [MWBaseObj MWFindDeviceList:para andType:_mType block:^(MWBaseObj *info, NSArray *mArr) {
            if (info.err_code == 0) {
                [self.tableArr addObjectsFromArray:mArr];
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
                [self popViewController];
            }
            [self.tableView reloadData];
        }];
    }
    
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
    
    
    return self.tableArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    MWDeviceInfo *mDevice = self.tableArr[indexPath.row];
    
    WKChoiceWashTableViewCell *customCell = [[WKChoiceWashTableViewCell alloc] init];
    [customCell.mBtn setTitle:mDevice.name forState:0];
    customCell.mBtn.tag = defaultTag+indexPath.row;
    if (customCell.mBtn.tag == self.btnTag) {
        [customCell.mBtn setBackgroundColor:[UIColor colorWithRed:0.976470588235294 green:0.580392156862745 blue:0.274509803921569 alpha:1.00]];
        
        customCell.isSelect = YES;
        
    }else{
        [customCell.mBtn setBackgroundColor:[UIColor colorWithRed:0.733333333333333 green:0.772549019607843 blue:0.819607843137255 alpha:1.00]];
        
        customCell.isSelect = NO;
        
    }
    __weak WKChoiceWashTableViewCell *weakCell = customCell;
    [customCell setBtnSelectBlock:^(BOOL choice,NSInteger btnTag){
        if (choice) {
            [weakCell.mBtn setBackgroundColor:[UIColor colorWithRed:0.976470588235294 green:0.580392156862745 blue:0.274509803921569 alpha:1.00]];
            
            self.btnTag = btnTag;
            MLLog(@"$$$$$$%ld",(long)btnTag);
            MWDeviceInfo *mDevice = self.tableArr[btnTag];
            mWashID = mDevice.id;
            [self.tableView reloadData];
            
            
            
        }
        else{
            //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
            [weakCell.mBtn setBackgroundColor:[UIColor colorWithRed:0.733333333333333 green:0.772549019607843 blue:0.819607843137255 alpha:1.00]];
            
            self.btnTag = btnTag;
            [self.tableView reloadData];
            MLLog(@"#####%ld",(long)btnTag);
        }
    }];
    
    cell = customCell;
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MLLog(@"选择了%ld行",(long)indexPath.row);
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
    MWDeviceInfo *mPDevice = [MWDeviceInfo new];
    if (self.tableArr.count>0) {
        if (mWashID.length==0) {
            mPDevice  = self.tableArr[0];
            mWashID = mPDevice.id;
        }
        
        
    }
    if (mWashID.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择洗衣类型"];
        return;
        
    }
    if (_mCode.length==0) {
        _mCode = @"0";
    }
    
    NSString *mWId = @"";
    if (_mType == 1) {
        mWId = @"0";
    }else{
        mWId = _mDeviceInfo.wash_id;
    }
    
    [MWBaseObj MWCcommitWashOrder:@{@"member_id":[WKUser currentUser].member_id,@"wash_id":mWId,@"wash_feature":mWashID,@"device_barcode":_mCode} block:^(MWBaseObj *info,MWWashOrderObj *mOrderObj) {
        if (info.err_code == 0) {
            WKWashGoPayViewController *vc = [WKWashGoPayViewController new];
            vc.mOrderInfo = mOrderObj;
            [self pushViewController:vc];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
    }];
    
}
- (void)WKWashBookingCellBtnAction:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了%ld行",mIndexPath.row);
    
}

@end
