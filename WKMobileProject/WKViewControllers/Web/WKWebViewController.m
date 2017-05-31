//
//  WKWebViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/19.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWebViewController.h"

@interface WKWebViewController ()

@end

@implementation WKWebViewController
{
    WXSDKInstance *mWxInstance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)initView{

    mWxInstance = [[WXSDKInstance alloc] init];
    mWxInstance.viewController = self;
    mWxInstance.frame = self.view.frame;
    
    __weak typeof (self)weakSelf = self;

    mWxInstance.onCreate = ^(UIView *view){

    };

    
    mWxInstance.onFailed = ^(NSError *error) {
        
    };
    
    mWxInstance.renderFinish = ^(UIView *view) {
        
    };
    
    NSURL *mUrl = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"js"];
    [mWxInstance renderWithURL:mUrl options: @{@"bundleUrl":[self.url absoluteString]} data:nil];

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
- (void)dealloc{
    [mWxInstance destroyInstance];
}
@end
