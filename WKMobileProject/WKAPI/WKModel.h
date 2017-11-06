//
//  WKModel.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/31.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKHeader.h"
#import "WKHttpRequest.h"
#import "NSNetworkManager.h"

#import "WKBDModel.h"
@interface WKBaseInfo : NSObject

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *retCode;

@property (assign,nonatomic) int status;

@property (nonatomic,strong) id result;

/**
 返回错误

 @param error 错误
 @return 返回baseinfo
 */
+(WKBaseInfo *)infoWithError:(NSError *)error;

/**
 返回错误信息

 @param errMsg 信息
 @return 返回baseinfo
 */
+(WKBaseInfo *)infoWithErrorMessage:(NSString *)errMsg;

/**
 返回成功信息

 @param successMsg 信息
 @return 返回baseinfo
 */
+(WKBaseInfo *)infoWithSuccessMessage:(NSString *)successMsg;

/**
 需要登录

 @param errMsg 错误信息
 @return 返回baseinfo
 */
+(WKBaseInfo *)infoWithReLoginErrorMessage:(NSString *)errMsg;

+ (void)WKFindTrainNumber:(NSDictionary *)param block:(void(^)(WKBaseInfo *info,NSArray *list))block;

@end

@interface WKUser : NSObject

@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,assign) NSInteger user_id;


/**
 手机号码登录

 @param param 参数
 @param block 返回信息
 */
+ (void)WKUserLoginWithMobile:(NSDictionary *)param block:(void(^)(WKBaseInfo *info))block;


/**
 验证码登录

 @param param 参数
 @param block 返回信息
 */
+ (void)WKVeryfyLogin:(NSDictionary *)param block:(void(^)(WKBaseInfo *info))block;

/**
 获取验证码

 @param param 参数
 @param block 返回信息
 */
+ (void)WKGetVeryfyCode:(NSDictionary *)param block:(void(^)(WKBaseInfo *info))block;

/**
 注册

 @param param 参数
 @param block 返回信息
 */
+ (void)WKUserRegist:(NSDictionary *)param block:(void(^)(WKBaseInfo *info))block;
@end

@class body;
@interface WKModel : NSObject

@property (strong,nonatomic) body *body;

@end

@interface body : NSObject

@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *name;

@end
@interface WKTrainName : NSObject

@property (nonatomic,strong) NSString *arriveTime;
@property (nonatomic,strong) NSString *endStationName;
@property (nonatomic,strong) NSString *startStationName;
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *stationName;
@property (nonatomic,strong) NSString *stationNo;
@property (nonatomic,strong) NSString *stationTrainCode;
@property (nonatomic,strong) NSString *stopoverTime;
@property (nonatomic,strong) NSString *trainClassName;

@end

@interface WKFunc : NSObject

@property (nonatomic,strong) NSString *mFuncName;
@property (nonatomic,strong) NSString *mFuncImg;

@end

@interface WKHome  : NSObject
///0：首页banner，1：推荐，2：活动
@property (nonatomic,assign) NSNumber *banner_type;
///标题
@property (nonatomic,strong) NSString *banner_title;
///图片url
@property (nonatomic,strong) NSString *banner_img;
///跳转url
@property (nonatomic,strong) NSString *banner_skip_content;


/**
 获取首页数据

 @param para 参数
 @param block 返回信息
 */
+ (void)WKGetHomeList:(NSDictionary *)para block:(void(^)(WKBaseInfo *info,NSArray *mArr))block;

@end
@class WKBaseInfo;
@class WKJUHEObj;
@interface WKNews  : NSObject
///0：首页banner，1：推荐，2：活动
@property (nonatomic,assign) NSNumber *uniquekey;
///标题
@property (nonatomic,strong) NSString *title;
///图片url
@property (nonatomic,strong) NSString *date;
///跳转url
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *author_name;

@property (nonatomic,strong) NSString *url;

@property (nonatomic,strong) NSString *thumbnail_pic_s;

@property (nonatomic,strong) NSString *thumbnail_pic_s02;

@property (nonatomic,strong) NSString *thumbnail_pic_s03;


/**
 获取聚合新闻数据
 
 @param para 参数
 @param block 返回信息
 */
+ (void)WKGetJuheNewsList:(NSDictionary *)para block:(void(^)(WKJUHEObj *info,NSArray *mArr))block;

+ (void)WKGetWeather:(NSDictionary *)para block:(void(^)(WKBaseInfo *info))block;

@end

@interface WKJUHEObj : NSObject

@property (nonatomic,strong) NSString *reason;

@property (nonatomic,assign) int error_code;

@property (assign,nonatomic) int status;

@property (nonatomic,strong) id result;

@end

@interface WKWechatObj : NSObject


@property (nonatomic,assign) int cid;

@property (nonatomic,strong) NSString *hitCount;

@property (assign,nonatomic) int id;

@property (nonatomic,strong) NSString *pubTime;

@property (nonatomic,strong) NSString *sourceUrl;

@property (nonatomic,strong) NSString *subTitle;

@property (nonatomic,strong) NSString *thumbnails;

@property (nonatomic,strong) NSString *title;


+ (void)WKGetWechat:(NSDictionary *)para block:(void(^)(WKBaseInfo *info,NSArray *mArr))block;
@end


#pragma mark-----****----三方登录
///
@interface ZLPlafarmtLogin : WKBDModel

@property (nonatomic, strong) NSString *            open_id;                ///
@property (nonatomic, strong) NSString *            nick_name;              ///
@property (nonatomic, strong) NSString *            photo;                  ///
@property (nonatomic, strong) NSString *            jpush;                  ///
@property (nonatomic, strong) NSString *            app_v;                  ///
@property (nonatomic, strong) NSString *            sys_v;                  ///
@property (nonatomic, strong) NSString *            sys_t;                  ///


@end
