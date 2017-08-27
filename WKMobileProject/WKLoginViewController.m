//
//  WKLoginViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/27.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKLoginViewController.h"
#import "WKHeader.h"
#import <Masonry.h>
#import "WKLoginView.h"
@interface WKLoginViewController ()<WKLoginViewDelegate>

@end

@implementation WKLoginViewController
{
    WKLoginView *mView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    
    mView = [WKLoginView shareView];
    mView.delegate = self;
    [self.view addSubview:mView];
    
    [mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view).offset(0);
    }];
    
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
/**
 按钮代理方法
 
 @param mTag 1:登录。2:qq登录。3:微信登录
 */
- (void)WKLoginViewBtnActions:(NSInteger)mTag{
    MLLog(@"你惦记的按钮式：%ld",mTag);
    switch (mTag) {
        case 1:
        {
        [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 2:
        {
        
        }
            break;
        case 3:
        {
        
        }
            break;
            
        default:
            break;
    }
}

/**
 输入框代理方法
 
 @param mTag 1:账户。2:密码。
 @param mText 放回当前输入的文本内容
 */
- (void)WKLoginViewTextFieldDidEndEditing:(NSInteger)mTag currentText:(NSString *)mText{
    MLLog(@"点击的输入框是：%ld    内容是：%@",mTag,mText);
}
@end
