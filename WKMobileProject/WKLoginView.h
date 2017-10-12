//
//  WKLoginView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/27.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKLoginViewDelegate <NSObject>

@optional

/**
 按钮代理方法

 @param mTag 0:注册。1:登录。2:qq登录。3:微信登录
 */
- (void)WKLoginViewBtnActions:(NSInteger)mTag;

/**
 输入框代理方法

 @param mTag 1:账户。2:密码。
 @param mText 放回当前输入的文本内容
 */
- (void)WKLoginViewTextFieldDidEndEditing:(NSInteger)mTag currentText:(NSString *)mText;

@end



@interface WKLoginView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *mTextBgkView;

@property (weak, nonatomic) IBOutlet UITextField *mAcountTx;

@property (weak, nonatomic) IBOutlet UITextField *mPwdTx;

@property (weak, nonatomic) IBOutlet UIButton *mLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *mRegistBtn;

@property (weak, nonatomic) IBOutlet UIButton *mQQLogin;

@property (weak, nonatomic) IBOutlet UIButton *mWechatLogin;

@property (weak,nonatomic) id<WKLoginViewDelegate>delegate;

+ (WKLoginView *)shareView;

@end
