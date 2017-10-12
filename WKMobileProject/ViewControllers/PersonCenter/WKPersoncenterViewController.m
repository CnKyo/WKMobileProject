//
//  WKPersoncenterViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKPersoncenterViewController.h"
#import "WKPersonCellOne.h"
#import "WKPersonCellTwo.h"
#import "WKPersonCellThree.h"
#import "WKHeader.h"

#import "WKMyCollectionViewController.h"
#import "WKMyPayListViewController.h"
#import "WKMyMsgViewController.h"
@interface WKPersoncenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;

@end

@implementation WKPersoncenterViewController
{
    NSMutableArray *mTableArr;
    NSArray *mSArr;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    mTableArr = [NSMutableArray new];
    mSArr = @[@"我的发布",@"我的消费记录",@"我的消息"];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 3;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 2) {
        return 1;
    }else{
        return mSArr.count;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110;
    }else if (indexPath.section == 2){
        
        return 90;
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
        return cell;
        
    }else if (indexPath.section == 2){
        CellId = @"cell3";
        
        WKPersonCellThree *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        CellId = @"cell2";
        
        WKPersonCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mContent.text = [NSString stringWithFormat:@"%@",mSArr[indexPath.row]];
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    if (indexPath.section == 0) {
        MLLog(@"个人信息");
        
    }else if (indexPath.section == 2){
        MLLog(@"退出");
        
        
    }else{
        if (indexPath.row == 0) {
            WKMyCollectionViewController *vc = [WKMyCollectionViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            
            WKMyPayListViewController *vc = [WKMyPayListViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            MLLog(@"其他 ");
            WKMyMsgViewController *vc = [WKMyMsgViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
        
    }
    
}

@end
