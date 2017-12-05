//
//  WKDeviceListViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/21.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKDeviceListViewController.h"
#import "WKPersonCellOne.h"
#import "WKPersonCellTwo.h"
#import "WKPersonCellThree.h"
#import "WKHeader.h"

#import "WKMyCollectionViewController.h"
#import "WKMyPayListViewController.h"
#import "WKMyMsgViewController.h"
#import "WKMoveHistoryViewController.h"

#import "WKDeviceDetailTableViewCell.h"
#import "WKCameraTableViewCell.h"
#import "WKCameraViewController.h"
@interface WKDeviceListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;

@end

@implementation WKDeviceListViewController
{
    NSMutableArray *mTableArr;
    NSArray *mSArr;
    NSArray *mTArr;
    NSArray *mIArr;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的蜂场";
    mTableArr = [NSMutableArray new];
    mSArr = @[@"https://tbm.alicdn.com/Y73o4CKjm22oPjIGMxw/7149iEtPiobvJOHhfVz%40%40ld.mp4",@"https://cloud.video.taobao.com/play/u/3257655479/p/1/e/6/t/1/50008124793.mp4"];
    mTArr = @[@"蜂场东实时画面",@"蜂场西实时画面"];
    mIArr = @[@"icon_camera1",@"icon_camera2"];

    [self initView];
}
- (void)initView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = COLOR(247, 247, 247);
    
    UINib   *nib = [UINib nibWithNibName:@"WKDeviceDetailTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    
    nib = [UINib nibWithNibName:@"WKCameraTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else{
        return mSArr.count;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 160;
    }else{
        return 105;
        
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    if (indexPath.section == 0) {
        CellId = @"cell1";
        
        WKDeviceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        CellId = @"cell2";
        
        WKCameraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mName.text = mTArr[indexPath.row];
        cell.mImg.image = [UIImage imageNamed:mIArr[indexPath.row]];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    if (indexPath.section == 0) {
        MLLog(@"个人信息");
        
    }else{
       
        WKCameraViewController *vc = [WKCameraViewController new];
        vc.mUrlString = mSArr[indexPath.row];
        //        https://cloud.video.taobao.com/play/u/3257655479/p/1/e/6/t/1/50008124793.mp4
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
}

@end
