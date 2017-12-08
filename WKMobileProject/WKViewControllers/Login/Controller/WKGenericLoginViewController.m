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

#import "WKHeader.h"
#import "QUShareSDK.h"
#import <JPush/JPUSHService.h>
#import <BGFMDB.h>
#import "LTPickerView.h"

@interface WKGenericLoginViewController ()<WKGenericLoginCellDelegate>

@end

@implementation WKGenericLoginViewController
{
    WKUser *mUserInfo;
    MWSchoolInfo *mShoolObj;
    
    NSMutableArray *mShoolList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mUserInfo = [WKUser new];
    mShoolObj = [MWSchoolInfo new];
    mShoolList = [NSMutableArray new];
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
        switch (_mLoginType) {
            case WKLogin:
            {
            _mTitle = @"登录";
            
            }
                break;
            case WKVerifyCode:
            {
            _mTitle = @"验证码登录";
            
            }
                break;
            case WKRegist:
            {
            _mTitle = @"注册";
            
            }
                break;
                
            default:
                break;
        }
        WKGenericHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mTitle.text = _mTitle;

        return cell;
        
    }else{
        switch (_mLoginType) {
            case WKLogin:
            {
            reuseCellId = @"loginCell";
            _mTitle = @"登录";
            
            }
                break;
            case WKVerifyCode:
            {
            reuseCellId = @"VerifyCodeCell";
            _mTitle = @"验证码登录";
            
            }
                break;
            case WKRegist:
            {
            reuseCellId = @"registCell";
            _mTitle = @"注册";
            
            }
                break;
                
            default:
                break;
        }
        
        self.navigationItem.title = _mTitle;
        WKGenericLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell.mSelectedSchoolBtn addTarget:self action:@selector(mSelectedShoolAction) forControlEvents:UIControlEventTouchUpInside];
        if (mShoolObj.schoolname.length != 0) {
            [cell.mSelectedSchoolBtn setTitle:mShoolObj.schoolname forState:0];
        }else{
            [cell.mSelectedSchoolBtn setTitle:@"选择学校" forState:0];
        }
            
        return cell;
    }
}
- (void)mSelectedShoolAction{
    [SVProgressHUD showWithStatus:@"正在获取学校信息!"];
    [MWBaseObj MWRegistGetSchoolInfo:@{@"school_id":@"0"} block:^(MWBaseObj *info, NSArray *mArr) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self initLTPickerView:mArr];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [SVProgressHUD dismiss];
    }];
}
- (void)initLTPickerView:(NSArray *)mList{
    
    NSMutableArray *mListArr = [NSMutableArray new];
    for (MWSchoolInfo *mShool in mList) {
        [mListArr addObject:mShool.schoolname];
    }
    
    LTPickerView *LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mListArr;//设置要显示的数据
    LtpickerView.defaultStr = mListArr[0];//默认选择的数据
    [LtpickerView show];//显示
    
    //回调block
    LtpickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        MLLog(@"选择了第%d行的%@",num,str);
        MWSchoolInfo *mShoolInfo = mList[num];
        mShoolObj = mShoolInfo;
        
        [self.tableView reloadData];
        
    };
    
}
#pragma mark----****----登录注册验证码cell代理方法
/**
 注册cell按钮代理方法
 
 @param mTag 1:登录  2:免费注册  3:验证码登录。 4:1取验证码。 5：注册。 6:已有账号直接登录
 */
- (void)WKGenericRegistCellDelegateWithBtnAction:(NSInteger)mTag{
    MLLog(@"tag是：%ld",mTag);
    switch (mTag) {
        case 1:
        {
        if (self.mLoginType == WKVerifyCode) {
            if (mUserInfo.mobile.length<=0 || mUserInfo.verifycode.length<=0) {
                [SVProgressHUD showErrorWithStatus:@"请输入手机号和验证码！"];
                return;
            }else{
                [SVProgressHUD showWithStatus:@"正在登录..."];

                [MWBaseObj MWVeryfyCodeLogin:@{@"mobile":mUserInfo.mobile,@"verifycode":mUserInfo.verifycode} block:^(MWBaseObj *info) {
                    if (info.err_code == 0) {
                        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                        [self dismissViewControllerAnimated:YES completion:^{
//                            self.mBlock(1);

                            [[NSNotificationCenter defaultCenter] postNotificationName:KAppFetchJPUSHService object:nil];
                            
                        }];
                    }else{
                        [SVProgressHUD showErrorWithStatus:info.err_msg];
                    }
                }];
            }
        }else if (self.mLoginType == WKRegist){
            if (mUserInfo.password.length<=0 || mUserInfo.user_name.length<=0 || mUserInfo.verifycode.length <= 0) {
                [SVProgressHUD showErrorWithStatus:@"请完善注册信息！"];
                return;
            }else{
                [SVProgressHUD showWithStatus:@"正在注册..."];

                [MWBaseObj MWRegist:@{@"mobile":mUserInfo.mobile,@"password":mUserInfo.password,@"verifycode":mUserInfo.verifycode,@"school_name":mShoolObj.schoolname,@"school_id":mShoolObj.schoolid,@"recommender_mobile":mUserInfo.recommender_mobile} block:^(MWBaseObj *info) {
                    if (info.err_code == 0) {
                        [SVProgressHUD showSuccessWithStatus:@"注册成功,请登录!"];
                        self.mLoginType = WKLogin;
                        [self.tableView reloadData];

                    }else{
                        [SVProgressHUD showErrorWithStatus:info.err_msg];
                    }
                }];
            }
        }else{
            if (mUserInfo.password.length<=0 || mUserInfo.mobile.length<=0) {
                [SVProgressHUD showErrorWithStatus:@"请输入手机号和密码！"];
                return;
            }else{
                [SVProgressHUD showWithStatus:@"正在登录..."];

                [MWBaseObj MWLoginWithPhone:@{@"mobile":mUserInfo.mobile,@"password":mUserInfo.password} block:^(MWBaseObj *info) {
                    if (info.err_code == 0) {
                        WKUser *mU = [WKUser currentUser];

                        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                        [self dismissViewControllerAnimated:YES completion:^{
//                            self.mBlock(1);
                    
//                            [[NSNotificationCenter defaultCenter] postNotificationName:KAppFetchJPUSHService object:nil];
                            
                        }];
                    }else{
                        [SVProgressHUD showErrorWithStatus:info.err_msg];
                    }
                }];
            }
        }
        
        
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
        if (mUserInfo.mobile.length<=0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
            return;
        }
        if (![Util isMobileNumber:mUserInfo.mobile]) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
            return;
        }
        [SVProgressHUD showWithStatus:@"正在获取发送验证码..."];
        int mType;
        if (self.mLoginType == WKRegist) {
            mType = 2;
        }else{
            mType = 1;
        }
        [MWBaseObj MWGetMobileVeryfyCode:@{@"mobile":mUserInfo.mobile,@"type":NumberWithInt(mType)} block:^(MWBaseObj *info) {
            if (info.err_code == 0) {
                [SVProgressHUD showSuccessWithStatus:info.err_msg];
            }else{
                [SVProgressHUD showErrorWithStatus:info.err_msg];
            }
        }];
       
        }
            break;
        case 5:
        {
        
        if (mUserInfo.password.length<=0 || mUserInfo.mobile.length<=0 || mUserInfo.verifycode.length <= 0 || mShoolObj.schoolid.length == 0 || mUserInfo.recommender_mobile.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请完善注册信息！"];
            return;
        }else{
            [SVProgressHUD showWithStatus:@"正在注册..."];
            if (mShoolObj.schoolid.length == 0) {
                mShoolObj.schoolid = @"0";
            }
            if (mShoolObj.schoolname.length == 0) {
                mShoolObj.schoolname = @"0";
            }
            [MWBaseObj MWRegist:@{@"mobile":mUserInfo.mobile,@"password":mUserInfo.password,@"verifycode":mUserInfo.verifycode,@"school_name":mShoolObj.schoolname,@"school_id":mShoolObj.schoolid,@"recommender_mobile":mUserInfo.recommender_mobile} block:^(MWBaseObj *info) {
                if (info.err_code == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"注册成功,请登录!"];
                    self.mLoginType = WKLogin;
                    [self.tableView reloadData];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:info.err_msg];
                }
            }];
        }
        
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
    switch (mTag) {
        case 1:
        {
        mUserInfo.user_name = mText;

        }
            break;
        case 6:
        {
        mUserInfo.verifycode = mText;
        }
            break;
        case 20:
        {
        mUserInfo.password = mText;
        
        }
            break;
        case 11:
        {
        mUserInfo.mobile = mText;
        
        }
            break;
        case 17:
        {
        mUserInfo.recommender_mobile = mText;
        
        }
            break;
        case 50:
        {
        mUserInfo.school_name = mText;
        }
            break;
            
        default:
            break;
    }
}
/**
 * 协议中的方法，获取返回按钮的点击事件
 */
- (void)navigationShouldPopOnBackButton
{
    if (_mLoginType == WKLogin) {
        [self popViewController];
    }else{
        _mLoginType = WKLogin;
        [self.tableView reloadData];
    }
    
}
/**
 微信QQ登录
 
 @param mTag 1:QQ。 2:微信。
 */
- (void)WKQQAndWechatLogin:(NSInteger)mTag{
    MLLog(@"XXXXXX:%ld",mTag);
    //    [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
    //    [self dismissViewControllerAnimated:YES completion:^{
    //        self.mBlock(1);
    //    }];
    
    
    SSDKPlatformType mType;
    if (mTag == 1) {
        mType = SSDKPlatformTypeQQ;
    }else{
        mType = SSDKPlatformTypeWechat;
    }
    [SVProgressHUD showWithStatus:@"正在登录中..."];
    
    [[QUShareSDK shared] getUserInfoWithType:mType call:^(SSDKUser *user, NSError *error) {
        MLLog(@"第撒放登录得到的用户信息是：%@",user);
        
        if (user != nil) {
            MLLog(@"三方登录返回的数据-----：%@",user);
            MLLog(@"%@",user.uid);
            if (mType == SSDKPlatformTypeQQ) {
                mUserInfo.open_id = user.credential.uid;
                mUserInfo.photo = [user.rawData objectForKey:@"figureurl_qq_2"];
            }else if (mType == SSDKPlatformTypeWechat){
                mUserInfo.open_id = [user.rawData objectForKey:@"openid"];
                mUserInfo.photo = [user.rawData objectForKey:@"headimgurl"];
            }
            //            mUserInfo.nick_name = [user.rawData objectForKey:@"nickname"];
            mUserInfo.app_v = [Util getAppVersion];
            mUserInfo.sys_v = [Util getDeviceModel];
            mUserInfo.sys_t = @"ios";
            mUserInfo.jpush = [JPUSHService registrationID];
            
            NSMutableDictionary *para = [NSMutableDictionary new];
            [para setObject:mUserInfo.open_id forKey:@"openid"];
            
            
            [WKUser WKRegistWechatOpenId:para block:^(MWBaseObj *info) {
                if (info.err_code == 0) {
                    mUserInfo.token = [[info.data objectForKey:@"user_info"] objectForKey:@"token"];
                    mUserInfo.user_id = [[info.data objectForKey:@"user_info"] objectForKey:@"user_id"];
                    [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                    [self dismissViewControllerAnimated:YES completion:^{
                        self.mBlock(1);
                        //                        [WKUser bg_clear];
                        //                        [mUserInfo bg_save];
                        [WKUser saveUserInfo:[info.data objectForKey:@"user_info"]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:KAppFetchJPUSHService object:nil];
                        
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:info.err_msg];
                }
            }];
            
            
        } else {
            MLLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:error.description];
        }
    }];
    
}
@end
