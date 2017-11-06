//
//  QUShareSDK.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2017/2/3.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "QUShareSDK.h"

#import <UIKit/UIKitDefines.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MessageUI/MessageUI.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@implementation QUShareSDK


#define ShareTitle (@"重庆发现购科技有限公司")
#define ShareWebURL (@"http://go.chinafxg.com")

+ (QUShareSDK *)shared {
    static QUShareSDK *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[QUShareSDK alloc] init];
    });
    return _sharedClient;
}

- (id)init
{
    if(self = [super init])
    {
        self.infoDict = [NSMutableDictionary dictionary];
    }
    return self;
}



- (BOOL)applicationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeQQ),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeMail),
                                        @(SSDKPlatformTypeSMS),
                                        @(SSDKPlatformTypeCopy)] onImport:^(SSDKPlatformType platformType) {
                                            switch (platformType)
                                            {
                                                case SSDKPlatformTypeWechat:
                                                [ShareSDKConnector connectWeChat:[WXApi class]];
                                                break;
                                                case SSDKPlatformTypeQQ:
                                                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                break;
                                                default:
                                                break;
                                            }
                                        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                            switch (platformType)
                                            {
                                                case SSDKPlatformTypeWechat:
                                                [appInfo SSDKSetupWeChatByAppId:ShareSDK_WeChat_AppId
                                                                      appSecret:ShareSDK_WeChat_AppSecret];
                                                break;
                                                case SSDKPlatformTypeQQ:
                                                [appInfo SSDKSetupQQByAppId:ShareSDK_QQ_AppId
                                                                     appKey:ShareSDK_QQ_AppKey
                                                                   authType:SSDKAuthTypeBoth];
                                                break;
                                                default:
                                                break;
                                            }
                                        }];
//    [ShareSDK registerApp:ShareSDK_AppKey
//          activePlatforms:@[@(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeMail),
//                            @(SSDKPlatformTypeSMS),
//                            @(SSDKPlatformTypeCopy)]
//                 onImport:^(SSDKPlatformType platformType) {
//                     switch (platformType)
//                     {
//                         case SSDKPlatformTypeWechat:
//                             [ShareSDKConnector connectWeChat:[WXApi class]];
//                             break;
//                         case SSDKPlatformTypeQQ:
//                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                             break;
//                         default:
//                             break;
//                     }
//                 }
//          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//              switch (platformType)
//              {
//                  case SSDKPlatformTypeWechat:
//                      [appInfo SSDKSetupWeChatByAppId:ShareSDK_WeChat_AppId
//                                            appSecret:ShareSDK_WeChat_AppSecret];
//                      break;
//                  case SSDKPlatformTypeQQ:
//                      [appInfo SSDKSetupQQByAppId:ShareSDK_QQ_AppId
//                                           appKey:ShareSDK_QQ_AppKey
//                                         authType:SSDKAuthTypeBoth];
//                      break;
//                  default:
//                      break;
//              }
//          }];
    
    return YES;
}



#pragma mark - 分享内容

/**
 *	@brief	分享全部
 *
 *	@param 	sender 	事件对象
 */
- (void)shareAllButtonClickHandler:(UIButton *)sender imageUrl:(NSString *)imageUrl title:(NSString *)title content:(NSString *)content description:(NSString *)des linkUrl:(NSString *)url
{
    if (title==nil || title.length==0)
        title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (content==nil || content.length == 0)
        content = @"重庆发现之旅科技有限公司\n";
    
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:@[imageUrl]
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:sender
                                                                     items:nil
                                                               shareParams:shareParams
                                                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                           switch (state) {
                                                               case SSDKResponseStateBegin:
                                                               {
                                                                   [SVProgressHUD showWithStatus:@"分享中..."];;
                                                                   break;
                                                               }
                                                               case SSDKResponseStateSuccess:
                                                               {
                                                                   [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                                                                   break;
                                                               }
                                                               case SSDKResponseStateFail:
                                                               {
                                                                   if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                                                                   {
                                                                       [SVProgressHUD showErrorWithStatus:@"分享失败"];
                                                                       break;
                                                                   }
                                                                   else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                                                                   {
                                                                       [SVProgressHUD showErrorWithStatus:@"分享失败"];
                                                                       break;
                                                                   }
                                                                   else
                                                                   {
                                                                       [SVProgressHUD showErrorWithStatus:@"分享失败"];
                                                                       break;
                                                                   }
                                                                   break;
                                                               }
                                                               case SSDKResponseStateCancel:
                                                               {
                                                                   [SVProgressHUD showInfoWithStatus:@"分享取消"];
                                                                   break;
                                                               }
                                                               default:
                                                                   break;
                                                           }
                                                           
                                                       }];
    
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeCopy)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeMail)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSMS)];
//    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeQQ)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeWechat)];
}

#pragma mark - 用户资料读取
- (void)getUserInfoWithType:(SSDKPlatformType)shareType call:( void(^)(SSDKUser *user, NSError *error))callback
{
    [SSEThirdPartyLoginHelper loginByPlatform:shareType
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       callback(user, nil);
                                       NSLog(@"user: %@", user);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    NSLog(@"error:%@",error);
                                    callback(nil, error);
                                }];
}



@end
