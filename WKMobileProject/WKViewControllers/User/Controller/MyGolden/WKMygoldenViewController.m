//
//  WKMygoldenViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMygoldenViewController.h"

@interface WKMygoldenViewController ()

@end

@implementation WKMygoldenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"金币";
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKMyOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");
}
- (void)tableViewFooterReloadData{
    MLLog(@"刷尾");
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
