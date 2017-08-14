//
//  WKEditUserinfoViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKEditUserinfoViewController.h"
#import "WKEditUserInfoCell.h"
#import "WKChangeUserInfoViewController.h"
@interface WKEditUserinfoViewController ()<WKEditUserInfoCellDelegate>

@end

@implementation WKEditUserinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKEditUserInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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

    return 600;
 
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    reuseCellId = @"cell";
    
    WKEditUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    
    return cell;
   
    
    
    
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
 修改用户信息界面按钮点击代理方法
 
 @param mType 选择的按钮类型（1头像，2用户名，3手机号，4真实信息，5证件号，6登录密码，7退出登录）
 */
- (void)WKEditUserInfoCellDelegateWithBtnClicked:(WKEditUserInfoClicked)mType{
    MLLog(@"点击了%ld",mType);
    if (mType == 2) {
        WKChangeUserInfoViewController *vc = [WKChangeUserInfoViewController new];
        vc.mType = WKChangeNormalInfo;
        [self pushViewController:vc];
    }else if (mType == 6){
        WKChangeUserInfoViewController *vc = [WKChangeUserInfoViewController new];
        vc.mType = WKChangePwd;
        [self pushViewController:vc];
    }else{
    
    }
}
@end
