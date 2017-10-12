//
//  WKDiscoveryViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKDiscoveryViewController.h"

@interface WKDiscoveryViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WKDiscoveryViewController
{
    UITableView *mTableView;
    
    NSMutableArray *mTableArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发现";
    
    mTableArr = [NSMutableArray new];
    
    [self initView];
}

- (void)initView{
    
    
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

@end
