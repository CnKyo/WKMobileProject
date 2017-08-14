//
//  WKChangeUserInfoViewController.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"


typedef enum WKChangeUserInfoType {
    ///修改用户信息
    WKChangeNormalInfo = 1,
    ///修改密码
    WKChangePwd = 2
} WKChangeUserInfoType;

@interface WKChangeUserInfoViewController : WKBaseViewController

@property (nonatomic,assign)WKChangeUserInfoType mType;


@end
