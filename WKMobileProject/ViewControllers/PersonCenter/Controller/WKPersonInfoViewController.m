//
//  WKPersonInfoViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/21.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKPersonInfoViewController.h"
#import "WKPersonCellOne.h"
#import "WKPersonCellTwo.h"
#import "WKPersonCellThree.h"
#import "WKHeader.h"

#import "WKMyCollectionViewController.h"
#import "WKMyPayListViewController.h"
#import "WKMyMsgViewController.h"
#import "WKMoveHistoryViewController.h"
@interface WKPersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;

@end

@implementation WKPersonInfoViewController
{
    NSMutableArray *mTableArr;
    NSArray *mSArr;
    NSArray *mCArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人信息";
    mTableArr = [NSMutableArray new];
    mSArr = @[@"我的电话：",@"我的蜂龄：",@"我的生日：",@"我的地址:",@"身份证：",@"真实姓名：",@"性别：",@"蜂群数量："];
    mCArr = @[@"133****3333",@"3年",@"1955-09-09",@"重庆市渝中区较场口",@"5123******123123",@" 张三",@"男",@"1个"];

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
    
    UINib   *nib = [UINib nibWithNibName:@"WKPersonCellOne" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    
    nib = [UINib nibWithNibName:@"WKPersonCellTwo" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    nib = [UINib nibWithNibName:@"WKPersonCellThree" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    
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
        return 110;
    }else{
        return 45;
        
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    if (indexPath.section == 0) {
        CellId = @"cell1";
        
        WKPersonCellOne *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mLine.hidden = YES;
        return cell;
        
    }else{
        
        CellId = @"cell2";
        
        WKPersonCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mContent.text = [NSString stringWithFormat:@"%@",mSArr[indexPath.row]];
        cell.mName.text = [NSString stringWithFormat:@"%@",mCArr[indexPath.row]];
        cell.mLine.hidden = YES;
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
        if (indexPath.row == 0) {
            WKMyCollectionViewController *vc = [WKMyCollectionViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            
            WKMyPayListViewController *vc = [WKMyPayListViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            
            WKMyPayListViewController *vc = [WKMyPayListViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            MLLog(@"其他 ");
            WKMoveHistoryViewController *vc = [WKMoveHistoryViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
        
    }
    
}
@end
