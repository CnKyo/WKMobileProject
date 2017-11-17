//
//  WKPayWashView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WPHotspotLabel.h>
#import "WKCountLabel.h"

///
@protocol WKPayWashViewDelegate <NSObject>

@optional

/**
 支付方式代理方法

 @param mType 返回支付方式
 */
- (void)WKPayWashViewDelegateCurrentPayType:(NSInteger)mType;
///去支付代理方法
- (void)WKPayWashViewDelegateWithPayBtnClicked;

@end

@interface WKPayWashView : UIView
///详情
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mDetailTx;
///倒计时
@property (weak, nonatomic) IBOutlet WKCountLabel *mCountTimeTx;
///支付金额
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mPayPriceTx;
///支付按钮
@property (weak, nonatomic) IBOutlet UIButton *mPayBtn;
///设置嗲里
@property (weak,nonatomic) id<WKPayWashViewDelegate>delegate;
///支付数组
@property (strong,nonatomic)  NSMutableArray *mPayTypeArr;
///微信支付
@property (weak, nonatomic) IBOutlet UIButton *mWechatBtn;
///支付宝支付
@property (weak, nonatomic) IBOutlet UIButton *mAlipayBtn;
///银联支付
@property (weak, nonatomic) IBOutlet UIButton *mUnionPayBtn;
    
///金币支付
@property (weak, nonatomic) IBOutlet UIButton *mCoinBtn;
///初始化view
+ (WKPayWashView *)initView;

@end
