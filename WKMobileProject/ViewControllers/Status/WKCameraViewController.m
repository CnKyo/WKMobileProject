//
//  WKCameraViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKCameraViewController.h"
#import "ZGLVideoPlyer.h"

@interface WKCameraViewController ()
@property (nonatomic, strong) ZGLVideoPlyer *player;

@end

@implementation WKCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"查看摄像机";
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat deviceWith = [UIScreen mainScreen].bounds.size.width;
    
    self.player = [[ZGLVideoPlyer alloc]initWithFrame:CGRectMake(0, 20, deviceWith, 300)];
    self.player.videoUrlStr = _mUrlString;
    
    [self.view addSubview:self.player];
    
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
