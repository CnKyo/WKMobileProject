//
//  WKMyCarViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyCarViewController.h"
#import "WKMyCarCell.h"
#import "WKHeader.h"
#import <BAButton.h>
#import "WKBundlePersonMsgViewController.h"
@interface WKMyCarViewController ()

@end

@implementation WKMyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMTitle:@"我的车辆"];
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKMyCarCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self setMHiddenRightBtn:NO];
}
- (void)rightBtnAction{
    
    MLLog(@"添加车辆");
    WKBundlePersonMsgViewController *vc = [WKBundlePersonMsgViewController new];
    //        [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 2;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    CellId = @"cell";
    
    WKMyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
