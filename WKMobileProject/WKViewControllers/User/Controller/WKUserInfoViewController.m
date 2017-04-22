//
//  WKUserInfoViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/18.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserInfoViewController.h"

@interface WKUserInfoViewController ()

@end

@implementation WKUserInfoViewController

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
    _mText = @"this is content";

    self.block (_mText);
    [self.navigationController popViewControllerAnimated:YES];

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
