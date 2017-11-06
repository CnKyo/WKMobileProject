//
//  WKWechatLoginManager.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/6.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>

@interface WKWechatLoginManager : NSObject<WXApiDelegate>
+ (instancetype)shareManager;

+ (void)WechatLogin;
@end
