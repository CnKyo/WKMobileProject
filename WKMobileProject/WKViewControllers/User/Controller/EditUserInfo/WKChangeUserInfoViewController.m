//
//  WKChangeUserInfoViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKChangeUserInfoViewController.h"

#import "WKChangeUserInfoCell.h"
@interface WKChangeUserInfoViewController ()<WKChangeUserInfoCellDelegate>

@end

@implementation WKChangeUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *mT = nil;
    
    if (_mType == WKChangeNormalInfo) {
        mT = @"修改个人信息";
    }else{
        mT = @"修改密码";
    }
    
    self.navigationItem.title = mT;

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKChangeUserInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"WKChangePWDView" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"pwdcell"];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_mType == WKChangeNormalInfo) {
        return 100;
    }else{
        return 464;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (_mType == WKChangeNormalInfo) {
        reuseCellId = @"cell";

    }else{
        reuseCellId = @"pwdcell";

    }
    
    WKChangeUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.delegate  = self;
    return cell;
    
    
    
}

/**
 按钮点击代理方法
 
 @param mBtnTag 1:发生验证码。 2:确认修改
 */
- (void)WKChangeUserInfoCellWithBtnClickTag:(NSInteger)mBtnTag{
    MLLog(@"得到的内容是：%ld",(long)mBtnTag);

}


/**
 输入框代理方法
 
 @param mTextFieldTag 输入框tag值 11:手机号码。 6:验证码。 20:新密码。 other：个人信息
 @param mText 返回输入框内容
 */
- (void)WKChangeUserInfoCellWithTextFieldEndEditingWithTextFieldTag:(NSInteger)mTextFieldTag andText:(NSString *)mText{
    MLLog(@"得到的内容是：%@",mText);
}
@end
