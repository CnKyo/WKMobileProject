//
//  WKWashPayResultView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理
@protocol WKWashPayResultViewDelegate <NSObject>

@optional
///按钮代理方法
- (void)WKWashPayResultViewWithBackAction;

@end

@interface WKWashPayResultView : UIView
///状态
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
///内容
@property (weak, nonatomic) IBOutlet UILabel *mDetail;
///倒计时
@property (weak, nonatomic) IBOutlet UILabel *mCountTime;
///返回按钮
@property (weak, nonatomic) IBOutlet UIButton *mBackBtn;
///重新预约按钮
@property (weak, nonatomic) IBOutlet UIButton *mRebookingBtn;
///设置代理
@property (weak,nonatomic) id<WKWashPayResultViewDelegate>delegate;
///初始化成功view
+ (WKWashPayResultView *)initSucessView;
///初始化失败view
+ (WKWashPayResultView *)initErrorView;

#pragma mark----****----vip会员充值view
///会员充值返回消息说明
@property (weak, nonatomic) IBOutlet UILabel *mTopupMessageContent;
///会员充值图片
@property (weak, nonatomic) IBOutlet UIImageView *mTopupStatusImg;
///会员充值状态
@property (weak, nonatomic) IBOutlet UILabel *mTopupStatus;
///会员充值返回按钮
@property (weak, nonatomic) IBOutlet UIButton *mTopupBackBtn;
///vip背景色
@property (weak, nonatomic) IBOutlet UIView *mVipBgk;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTopupBackBtnContrains;


///初始化vipview
+ (WKWashPayResultView *)initVIPSucessView;

@end
