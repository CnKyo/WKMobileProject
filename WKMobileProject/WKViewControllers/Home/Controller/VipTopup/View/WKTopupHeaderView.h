//
//  WKTopupHeaderView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理
@protocol WKTopupHeaderViewDelegate <NSObject>

@optional

/**
 充值账号输入代理

 @param mText 返回文本
 */
- (void)WKTopupHeaderViewDelegateWithTextFieldEndEdit:(NSString *)mText;
///通讯录代理方法（为他人充值）
- (void)WKTopupHeaderViewDelegateWithAddressBookBtnClicked;

@end

@interface WKTopupHeaderView : UIView<UITextFieldDelegate>
///充值输入框
@property (weak, nonatomic) IBOutlet UITextField *mTopupTx;
///通讯录按钮
@property (weak, nonatomic) IBOutlet UIButton *mAddressBookBtn;
///到期时间
@property (weak, nonatomic) IBOutlet UILabel *mExpirationTime;
///设置代理
@property (weak,nonatomic) id<WKTopupHeaderViewDelegate>delegate;
///初始化view
+ (WKTopupHeaderView *)initview;
@end
