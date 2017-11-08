//
//  WKUserInfoCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
#import "ZYProGressView.h"

@protocol WKUserInfoCellDelegate <NSObject>

@optional
/**
 用户header按钮点击代理方法
 
 @param mTag 返回索引(0修改用户资料1签到2财富值3金币)
 */
- (void)WKUserInfoCellDelegateWithBtnClicked:(NSInteger)mTag;

@end

@interface WKUserInfoCell : UITableViewCell
///头像
@property (weak, nonatomic) IBOutlet UIImageView *mAvator;
///用户名
@property (weak, nonatomic) IBOutlet UILabel *mUserName;
///徽章view
@property (weak, nonatomic) IBOutlet UIView *mBadgeView;
///进度条view
@property (weak, nonatomic) IBOutlet UIView *mProgressView;
///等级
@property (weak, nonatomic) IBOutlet UILabel *mLevel;
///签到
@property (weak, nonatomic) IBOutlet UIButton *mSignBtn;
///财富值
@property (weak, nonatomic) IBOutlet UILabel *mTreasure;
///金币值
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mGold;
///设置代理
@property (weak,nonatomic)id<WKUserInfoCellDelegate>delegete;

@property (strong,nonatomic) ZYProGressView *mProgress;

@property (strong,nonatomic) NSString *mPressValue;

@property (strong,nonatomic) WKUser *mUserInfo;
@end
