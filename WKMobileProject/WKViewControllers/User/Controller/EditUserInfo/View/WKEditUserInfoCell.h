//
//  WKEditUserInfoCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"

@protocol WKEditUserInfoCellDelegate <NSObject>

@optional

/**
 修改用户信息界面按钮点击代理方法

 @param mType 选择的按钮类型（1头像，2用户名，3手机号，4真实信息，5证件号，6登录密码，7退出登录）
 */
- (void)WKEditUserInfoCellDelegateWithBtnClicked:(WKEditUserInfoClicked)mType;

@end

@interface WKEditUserInfoCell : UITableViewCell
///用户等级
@property (weak, nonatomic) IBOutlet UILabel *mUserLv;
///头像
@property (weak, nonatomic) IBOutlet UIImageView *mAvator;
///用户名
@property (weak, nonatomic) IBOutlet UILabel *mUserName;
///手机号
@property (weak, nonatomic) IBOutlet UILabel *mUserPhone;
///真实信息
@property (weak, nonatomic) IBOutlet UILabel *mRealName;
///证件号
@property (weak, nonatomic) IBOutlet UILabel *mUserCode;
///退出登录
@property (weak, nonatomic) IBOutlet UIButton *mLoginOutBtn;
///设置代理
@property (weak,nonatomic)id<WKEditUserInfoCellDelegate>delegate;
@property (strong,nonatomic) WKUser *mUserInfo;

@end
