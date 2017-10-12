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

@interface WKPersoncenterViewController ()

@end

@implementation WKPersoncenterViewController
{
    NSMutableArray *mTableArr;
    NSArray *mSArr;
    NSArray *mCArr;

    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMTitle:@"个人中心"];
    mTableArr = [NSMutableArray new];
    mSArr = @[@"我的姓名",@"我的身份证",@"我的电话",@"我的车牌号"];
    mCArr = @[@"张三",@"500*******1234",@"134****1234",@"渝A1234"];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initView{
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKPersonCellOne" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    
    nib = [UINib nibWithNibName:@"WKPersonCellTwo" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];


    
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
    
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 ) {
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
        return cell;
        
    }else{
        
        CellId = @"cell2";
        
        WKPersonCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mName.text = [NSString stringWithFormat:@"%@",mSArr[indexPath.row]];
        cell.mContent.text = [NSString stringWithFormat:@"%@",mCArr[indexPath.row]];
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
   
}

@end
