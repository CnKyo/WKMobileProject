//
//  WKChangeUserInfoCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"

#import "MZTimerLabel.h"

@protocol WKChangeUserInfoCellDelegate <NSObject>

@optional

/**
 按钮点击代理方法

 @param mBtnTag 1:发生验证码。 2:确认修改
 */
- (void)WKChangeUserInfoCellWithBtnClickTag:(NSInteger)mBtnTag;


/**
 输入框代理方法

 @param mTextFieldTag 输入框tag值 11:手机号码。 6:验证码。 20:新密码。 other：个人信息
 @param mText 返回输入框内容
 */
- (void)WKChangeUserInfoCellWithTextFieldEndEditingWithTextFieldTag:(NSInteger)mTextFieldTag andText:(NSString *)mText;

@end


@interface WKChangeUserInfoCell : UITableViewCell<UITextFieldDelegate,MZTimerLabelDelegate>
#pragma mark----****----个人信息编辑cell tx
@property (weak, nonatomic) IBOutlet UITextField *mEditTextField;

#pragma mark----****----修改密码cell
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;

@property (weak, nonatomic) IBOutlet UITextField *mCodeTx;

///倒计时label
@property (strong,nonatomic)  UILabel *timer_show;

@property (weak, nonatomic) IBOutlet UIButton *mCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *mNewPwdTx;

@property (weak, nonatomic) IBOutlet UITextField *mComfirmNewPwd;

@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;

@property (weak,nonatomic) id<WKChangeUserInfoCellDelegate>delegate;

@end
