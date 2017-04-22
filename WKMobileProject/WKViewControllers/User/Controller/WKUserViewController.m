//
//  WKUserViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserViewController.h"
#import "WKUserInfoViewController.h"
@interface WKUserViewController ()

@end

@implementation WKUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *mBtn = [UIButton new];
    mBtn.frame = CGRectMake(100, 100, 100, 100);
    mBtn.backgroundColor = [UIColor redColor];
    [mBtn addTarget:self action:@selector(mAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
}
- (void)mAction{
    WKUserInfoViewController *vc = [WKUserInfoViewController new];
    vc.block = ^(NSString *mBlock){
        NSLog(@"blok is :%@",mBlock);
    };
    [self.navigationController pushViewController:vc animated:YES];
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
