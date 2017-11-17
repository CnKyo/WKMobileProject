//
//  WKBuyGoldCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
///设置代理
@protocol WKBuyGoldCellDelegate <NSObject>

@optional

/**
 选择支付方式代理方法
 
 @param mType 返回当前选择的支付方式（1是微信支付，2是支付宝支付,0是未选择）
 */
- (void)WKBuyGoldCellDelegateWithPayType:(NSInteger)mType;

/**
 选择直接支付还是微信好友支付
 
 @param mTag 返回当前选择的支付方式（1是直接支付，2是微信好友支付）
 */
- (void)WKBuyGoldCellDelegateIsGoPayOrFriendPayBtnClicked:(NSInteger)mTag;

/**
 输入框代理方法

 @param mText 返回输入文本内容
 */
- (void)WKBuyGoldCellDelegateCurrentTextField:(NSString *)mText;

@end

@interface WKBuyGoldCell : UITableViewCell<UITextFieldDelegate>
///文本输入框背景view
@property (weak, nonatomic) IBOutlet UIView *mTxBgkView;
///数量tx
@property (weak, nonatomic) IBOutlet UITextField *mNumTx;
///支付金额
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mPayPrice;
///微信支付
@property (weak, nonatomic) IBOutlet UIButton *mWechatBtn;
///支付宝支付
@property (weak, nonatomic) IBOutlet UIButton *mAlipayBtn;
///银联支付
@property (weak, nonatomic) IBOutlet UIButton *mUnionPayBtn;
    
///去支付按钮
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;
///朋友代付按钮
@property (weak, nonatomic) IBOutlet UIButton *mFriendPayBtn;
///说明文本
@property (weak, nonatomic) IBOutlet UILabel *mExplain;
///设置代理
@property (weak,nonatomic) id<WKBuyGoldCellDelegate>delegate;
///选择支付类型数据源
@property (strong,nonatomic) NSMutableArray *mTypeArr;
@end
