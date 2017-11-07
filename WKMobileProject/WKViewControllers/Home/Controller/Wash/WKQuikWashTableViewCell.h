//
//  WKQuikWashTableViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理
@protocol WKQuikWashDelegate <NSObject>

@optional

/**
 充值账号输入代理
 
 @param mText 返回文本
 */
- (void)WKQuikWashDelegateWithTextFieldEndEdit:(NSString *)mText;
///通讯录代理方法（为他人充值）
- (void)WKQuikWashDelegateWithAddressBookBtnClicked:(NSInteger)mTag;

@end
@interface WKQuikWashTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mTextField;
@property (weak, nonatomic) IBOutlet UIButton *mCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *mScanBtn;
@property (weak,nonatomic) id<WKQuikWashDelegate>delegate;

@end
