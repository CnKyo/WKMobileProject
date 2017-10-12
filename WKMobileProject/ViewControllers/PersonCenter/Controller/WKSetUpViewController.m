//
//  WKSetUpViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKSetUpViewController.h"
#import "WKHeader.h"
#import "WKSetUpTableViewCell.h"

#import "WKSetUpBottomView.h"


@interface WKSetUpViewController ()

@end

@implementation WKSetUpViewController
{
    
    WKSetUpBottomView *mBottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMTitle:@"设置"];
    
    [self addTableView];
    // Do any additional setup after loading the view.
    UINib   *nib = [UINib nibWithNibName:@"WKSetUpTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self initBottomView];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 45;
    
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    CellId = @"cell";
    
    WKSetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    [self showBottomView];
    
}

- (void)initBottomView{
    mBottomView = [WKSetUpBottomView initView];
    mBottomView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, 120);
    [self.view addSubview:mBottomView];
    
}
- (void)showBottomView{
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mRR = mBottomView.frame;
        mRR.origin.y = DEVICE_Height-120;
        mBottomView.frame = mRR;
    }];
}
- (void)dissmiddBottomView{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mRR = mBottomView.frame;
        mRR.origin.y = DEVICE_Height;
        mBottomView.frame = mRR;
    }];
    
}
@end
