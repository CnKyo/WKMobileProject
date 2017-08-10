//
//  WKGenericLoginCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
#import "MZTimerLabel.h"

@protocol WKGenericLoginCellDelegate <NSObject>

@optional
#pragma mark----****----登录cell代理方法
/**
 登录cell按钮代理方法

 @param mTag 1:登录  2:免费注册  3:验证码登录
 */
//- (void)WKGenericLoginCellLoginDelegateWithBtnAction:(NSInteger)mTag;

///**
// 登录cell输入框代理方法
//
// @param mTag 1:登录  20:密码
// @param mText 输入内容
// */
//- (void)WKGenericLoginCellLoginDelegateWithTextFieldEiditingWithWithTag:(NSInteger)mTag andText:(NSString *)mText;
#pragma mark----****----验证码登录cell代理方法
/**
 验证码登录cell按钮代理方法

 @param mTag 1:登录  2:获取验证码
 */
//- (void)WKGenericVerifyCodeCellDelegateWithBtnAction:(NSInteger)mTag;
//
///**
// 验证码登录cell输入框代理方法
//
// @param mTag 1:用户名。 6:验证码
// @param mText 输入内容
// */
//- (void)WKGenericVerifyCodeCellDelegateWithTextFieldEditingWithTag:(NSInteger)mTag andText:(NSString *)mText;
#pragma mark----****----注册cell代理方法
/**
 注册cell按钮代理方法
 
 @param mTag 1:登录  2:免费注册  3:验证码登录。 4:获取验证码。 5：注册。 6:已有账号直接登录
 */
- (void)WKGenericRegistCellDelegateWithBtnAction:(NSInteger)mTag;

/**
 注册cell输入框代理方法

 @param mTag 11:用户名  6:验证码  20:密码。 17:手机号。 50:学校
 @param mText 输入内容
 */
- (void)WKGenericRegistCellDelegateWithTextFieldEditingWithTag:(NSInteger)mTag andText:(NSString *)mText;

@end

@interface WKGenericLoginCell : UITableViewCell<UITextFieldDelegate,MZTimerLabelDelegate>
#pragma mark----****----登录cell

/**
 用户名
 */
@property (weak, nonatomic) IBOutlet UITextField *mUserNameTx;

/**
 密码
 */
@property (weak, nonatomic) IBOutlet UITextField *mPwdTx;

/**
 登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mLoginBtn;

/**
 去注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoRegistBtn;

/**
 验证码登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mVerifyCodeLoginBtn;
#pragma mark----****----验证码cell

/**
 验证码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *mVerifyCodeTx;

/**
 获取验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGetVerifyCodeBtn;
#pragma mark----****----注册cell

/**
 确认密码
 */
@property (weak, nonatomic) IBOutlet UITextField *mComfirmPwdTx;

/**
 邀请人电话
 */
@property (weak, nonatomic) IBOutlet UITextField *mSharePersonPhoneTx;

/**
 学习
 */
@property (weak, nonatomic) IBOutlet UITextField *mSchoolTx;

/**
 注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRegistBtn;

/**
 去登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoLoginBtn;
///倒计时label
@property (strong,nonatomic)  UILabel *timer_show;

@property (nonatomic,weak) id<WKGenericLoginCellDelegate>delegate;

@end
