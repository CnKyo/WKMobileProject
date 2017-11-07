//
//  WKQuikWashViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKQuikWashViewController.h"
#import "WKScanDeviceViewController.h"
#import "WKQuikWashTableViewCell.h"
#import "WaskBookingResultController.h"
@interface WKQuikWashViewController ()<WKQuikWashDelegate>

@end

@implementation WKQuikWashViewController
{
    
    NSString *mCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"立即使用";
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKQuikWashTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

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
        return 330;

    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
   
        reuseCellId = @"cell";
        
        WKQuikWashTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        
        
        return cell;
  
    
}

/**
 充值账号输入代理
 
 @param mText 返回文本
 */
- (void)WKQuikWashDelegateWithTextFieldEndEdit:(NSString *)mText{
    mCode = mText;
}
///通讯录代理方法（为他人充值）
///通讯录代理方法（为他人充值）
- (void)WKQuikWashDelegateWithAddressBookBtnClicked:(NSInteger)mTag{
    switch (mTag) {
        case 1:
        {
        if (mCode.length<=0) {
            
        }else{
            WaskBookingResultController *vc = [WaskBookingResultController new];
            vc.mCode = mCode;
            [self pushViewController:vc];
        }
        
        }
            break;
        case 2:
        {
        
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WKScanDeviceViewController *vc = [board instantiateViewControllerWithIdentifier:@"scan"];;
        [self pushViewController:vc];
        }
            break;
            
        default:
            break;
    }
}
@end
