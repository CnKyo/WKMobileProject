//
//  WKWechatLoginManager.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/6.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWechatLoginManager.h"
#import "WKHeader.h"
@implementation WKWechatLoginManager
+ (instancetype)shareManager{
    
    static WKWechatLoginManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WKWechatLoginManager alloc] init];
    });
    return instance;
}
- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *res =(SendAuthResp *)resp;
        
    }
}
+ (void)WechatLogin{
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.openID = ShareSDK_WeChat_AppId;
    req.state = @"123";
    [WXApi sendReq:req];
}
- (void)loginWithWechat:(NSString *)code{
    __weak typeof (*&self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@""];
}
@end
