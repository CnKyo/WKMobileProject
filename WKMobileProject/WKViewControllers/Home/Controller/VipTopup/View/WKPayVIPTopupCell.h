//
//  WKPayVIPTopupCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
///设置代理
@protocol WKPayVIPTopupCellDelegate <NSObject>

@optional

/**
 选择支付方式代理方法

 @param mType 返回当前选择的支付方式（1是微信支付，2是支付宝支付,0是未选择）
 */
- (void)WKPayVIPTopupCellDelegeteWithPayType:(NSInteger)mType;

/**
 选择直接支付还是微信好友支付

 @param mTag 返回当前选择的支付方式（1是直接支付，2是微信好友支付）
 */
- (void)WKPayVIPTopupCellDelegeteIsGoPayOrFriendPayBtnClicked:(NSInteger)mTag;

@end

@interface WKPayVIPTopupCell : UITableViewCell
///充值账号
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mAcount;
///会员类型
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mVipType;
///到期时间
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mExpireTime;
///充值金额
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTopPrice;
///实付款支付金额
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mPayPrice;
///微信支付按钮
@property (weak, nonatomic) IBOutlet UIButton *mWechatBtn;
///支付宝支付按钮
@property (weak, nonatomic) IBOutlet UIButton *mAlipaybtn;
///去支付按钮
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;
///好友代付按钮
@property (weak, nonatomic) IBOutlet UIButton *mFriendPayBtn;
///选择支付类型数据源
@property (strong,nonatomic) NSMutableArray *mTypeArr;
///设置代理
@property (weak,nonatomic) id<WKPayVIPTopupCellDelegate>delegate;


@end
