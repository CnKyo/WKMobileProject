//
//  WKNearByViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKNearByViewController.h"

@interface WKNearByViewController ()

@end

@implementation WKNearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"附近的蜂农";
    
 
}
- (void)loadView{
    
    [super loadView];
    UIView *vc = [UIView new];
    vc.backgroundColor = [UIColor whiteColor];
    vc.frame = self.view.bounds;
    [self.view addSubview:vc];
    
    UIImageView *mimg = [UIImageView new];
    mimg.frame = vc.frame;
    mimg.image = [UIImage imageNamed:@"icon_nearby"];
    [vc addSubview:mimg];
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
