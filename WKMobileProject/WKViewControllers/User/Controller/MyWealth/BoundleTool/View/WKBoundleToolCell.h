//
//  WKBoundleToolCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKPasswordTextFiled.h"
#import "WKPwdText.h"
#import "WKHeader.h"
#import "WLUnitField.h"
#import "WKPwdTextField.h"
@protocol WKBoundleToolCellDelegate <NSObject>

@optional

/**
 选择提现账户类型

 @param mType 1微信支付，2支付宝支付
 */
- (void)WKBoundleToolCellDelegateDidSelectedType:(NSInteger)mType;

/**
 支付密码

 @param mTag 密码输入框tag。1是密码，2是确认密码  3是提现账户
 @param mText 返回输入框内容
 */
- (void)WKBoundleToolCellDelegateWithTag:(NSInteger)mTag WithPwdText:(NSString *)mText;

/**
 确认提交按钮
 */
- (void)WKBoundleToolCellDelegateWithCommitAction;


@end

@interface WKBoundleToolCell : UITableViewCell<WLUnitFieldDelegate,WKPwdTextFieldDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mWechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *mAlipayBtn;
///密码view
@property (weak, nonatomic) IBOutlet UIView *mPwdView;
///确认密码view
@property (weak, nonatomic) IBOutlet UIView *mComfirmPwdView;

/**
 提现账户
 */
@property (weak, nonatomic) IBOutlet UITextField *mAcountTx;
///提交按钮
@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;
///数据源
@property (strong,nonatomic) NSMutableArray *mArr;

@property (strong,nonatomic) WKPwdTextField *mPwdTx;
@property (strong,nonatomic) WLUnitField *mComPwdTx;

@property (weak,nonatomic) id<WKBoundleToolCellDelegate>delegate;

@end
