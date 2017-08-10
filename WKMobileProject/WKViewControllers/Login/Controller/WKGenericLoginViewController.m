//
//  WKGenericLoginViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKGenericLoginViewController.h"
#import "WKGenericHeaderCell.h"
#import "WKGenericLoginCell.h"
@interface WKGenericLoginViewController ()<WKGenericLoginCellDelegate>

@end

@implementation WKGenericLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _mTitle;
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKGenericHeaderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"headCell"];
    
    nib = [UINib nibWithNibName:@"WKGenericLoginCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"loginCell"];
    
    nib = [UINib nibWithNibName:@"WKGenericVerifyCodeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"VerifyCodeCell"];
    
    nib = [UINib nibWithNibName:@"WKGenericRegistCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"registCell"];

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
    
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }else{
        return 600;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"headCell";
        
        WKGenericHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
        return cell;

    }else{
        switch (_mLoginType) {
            case WKLogin:
            {
            reuseCellId = @"loginCell";

            }
                break;
            case WKVerifyCode:
            {
            reuseCellId = @"VerifyCodeCell";

            }
                break;
            case WKRegist:
            {
            reuseCellId = @"registCell";

            }
                break;
                
            default:
                break;
        }
        
        WKGenericLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
}
#pragma mark----****----登录注册验证码cell代理方法
/**
 注册cell按钮代理方法
 
 @param mTag 1:登录  2:免费注册  3:验证码登录。 4:获取验证码。 5：注册。 6:已有账号直接登录
 */
- (void)WKGenericRegistCellDelegateWithBtnAction:(NSInteger)mTag{
    MLLog(@"tag是：%ld",mTag);
    switch (mTag) {
        case 1:
        {
        
        }
            break;
        case 2:
        {
        self.mLoginType = WKRegist;
        [self.tableView reloadData];
        }
            break;
        case 3:
        {
        self.mLoginType = WKVerifyCode;
        [self.tableView reloadData];
        }
            break;
        case 4:
        {
        
        }
            break;
        case 5:
        {
        
        }
            break;
        case 6:
        {
        self.mLoginType = WKLogin;
        [self.tableView reloadData];
        }
            break;
            
        default:
            break;
    }
}

/**
 注册cell输入框代理方法
 
 @param mTag 1:用户名  6:验证码  20:密码。 11:手机号。 50:学校
 @param mText 输入内容
 */
- (void)WKGenericRegistCellDelegateWithTextFieldEditingWithTag:(NSInteger)mTag andText:(NSString *)mText{
    MLLog(@"tag是：%ld----输入的内容是：%@",mTag,mText);

}
@end
