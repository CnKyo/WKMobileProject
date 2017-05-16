//
//  WKUserViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserViewController.h"
#import "WKUserInfoViewController.h"

#import "WKUserInfoCell.h"
#import "WKUserInfoAdCell.h"
#import "WKUserFuncCell.h"
@interface WKUserViewController ()<WKUserInfoCellDelegate,WKUserInfoAdCellDelegate>

@end

@implementation WKUserViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarHairlineImageView.hidden = YES;
    
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    self.tableView.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKUserInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"headerCell"];
    
    nib = [UINib nibWithNibName:@"WKUserInfoAdCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"adCell"];
    
    nib = [UINib nibWithNibName:@"WKUserFuncCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"funcCell"];

    
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
    
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        return 15;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }else{
  
        UIView *mSectionView = [UIView new];
        mSectionView.backgroundColor = [UIColor colorWithRed:0.956862745098039 green:0.972549019607843 blue:0.996078431372549 alpha:1.00];
        return mSectionView;
    }
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 4;
    }else{
        return 6;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }else if(indexPath.section == 1){
        return 120;
    }else{
        return 50;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"headerCell";
        
        WKUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegete = self;

        return cell;
    }else if(indexPath.section == 1){
        reuseCellId = @"adCell";
        
        WKUserInfoAdCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegete = self;
        
        return cell;
    }else{
        
        reuseCellId = @"funcCell";
        
        WKUserFuncCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        return cell;
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        MLLog(@"%ld行",indexPath.row);
    }
    
}


#pragma mark----****----cell的代理方法
/**
 用户header按钮点击代理方法
 
 @param mTag 返回索引(0修改用户资料1签到2财富值3金币)
 */
- (void)WKUserInfoCellDelegateWithBtnClicked:(NSInteger)mTag{
    MLLog(@"选择的是:%ld",mTag);
}

/**
 左边按钮点击代理方法
 
 @param mIndexPath 返回索引
 */
- (void)WKUserInfoAdCellDelegateWithLeftBtn:(NSIndexPath *)mIndexPath{
    MLLog(@"选择的是:%ld",mIndexPath.row);

}
/**
 右边按钮点击代理方法
 
 @param mIndexPath 返回索引
 */
- (void)WKUserInfoAdCellDelegateWithRightBtn:(NSIndexPath *)mIndexPath{
    MLLog(@"选择的是:%ld",mIndexPath.row);

}
@end
