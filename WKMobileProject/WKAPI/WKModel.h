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
@class MWBaseObj;

@interface WKUser : NSObject

@property (nonatomic,assign) NSString *user_id;

@property (nonatomic, strong) NSString *            open_id;                ///
@property (nonatomic, strong) NSString *            photo;                  ///
@property (nonatomic, strong) NSString *            jpush;                  ///
@property (nonatomic, strong) NSString *            app_v;                  ///
@property (nonatomic, strong) NSString *            sys_v;                  ///
@property (nonatomic, strong) NSString *            sys_t;                  ///
@property (nonatomic, strong) NSString *            token;                  ///

@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *headimgurl;
@property (nonatomic, strong) NSString *            nickname;              ///
@property (nonatomic, strong) NSString *            regip;              ///
@property (nonatomic, strong) NSString *            school_id;                  ///
@property (nonatomic, strong) NSString *            wxoid;                  ///
+(void)saveUserInfo:(id)info;

///返回当前用户信息
+(WKUser *)currentUser;

///判断是否需要登录
+(BOOL)isNeedLogin;

+ (void)WKRegistWechatOpenId:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;

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



@class MWSchoolInfo;
@class MWDeviceCode;
@class MWBookingObj;


@interface MWBaseObj : NSObject

@property (nonatomic,strong) NSString *err_msg;

@property (nonatomic,assign) int err_code;

@property (assign,nonatomic) long time;

@property (assign,nonatomic) double utility_time;

@property (nonatomic,strong) id data;

/**
 返回错误
 
 @param error 错误
 @return 返回baseinfo
 */
+(MWBaseObj *)infoWithError:(NSError *)error;

/**
 返回错误信息
 
 @param errMsg 信息
 @return 返回baseinfo
 */
+(MWBaseObj *)infoWithErrorMessage:(NSString *)errMsg;

/**
 返回成功信息
 
 @param successMsg 信息
 @return 返回baseinfo
 */
+(MWBaseObj *)infoWithSuccessMessage:(NSString *)successMsg;

/**
 需要登录
 
 @param errMsg 错误信息
 @return 返回baseinfo
 */
+(MWBaseObj *)infoWithReLoginErrorMessage:(NSString *)errMsg;

/**
 获取学校列表

 @param para 参数
 @param block 返回值
 */
+ (void)MWGetSchoolList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block;
/**
 查询学校
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFindSchoolList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr,MWSchoolInfo *mSchool))block;
/**
 查询洗衣机
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFindDeviceList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block;
/**
 查询洗衣机信息
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFindDeviceInfo:(NSDictionary *)para block:(void(^)(MWBaseObj *info,MWBookingObj *mArr))block;
/**
 添加功能
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWAddDeviceFunc:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;
/**
 查询任务
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFindTaskList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block;

/**
 操作洗衣机
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWControlDevice:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;
/**
 获取洗衣机状态
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetDeviceStatus:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;

/**
 编号洗衣获取deviceCode

 @param mCode 编号
 @param block 返回值
 */
+ (void)MWWashToCode:(NSMutableDictionary *)para block:(void(^)(MWBaseObj *info,MWDeviceCode *mDeviceCode))block;

@end



@interface MWDeviceInfo : NSObject

@property (nonatomic,strong) NSString *location_name;

@property (nonatomic,assign) int device_id;
@property (nonatomic,assign) int money;

@property (nonatomic,assign) int school_id;

@property (nonatomic,strong) NSString *school_name;

@property (nonatomic,assign) int sum_money;

@end
@interface MWSchoolInfo : NSObject
@property (nonatomic,strong) NSString *school_name;
@property (nonatomic,strong) NSString *sum_money;
@end

@interface MWDeviceCode : NSObject
@property (nonatomic,strong) NSString *device_code;
@property (nonatomic,strong) NSString *device_id;
@property (nonatomic,strong) NSString *end_time;
@property (nonatomic,strong) NSString *location_name;
@property (nonatomic,strong) NSString *run_status;

@end
///扫描洗衣机后的对象
@interface MWBookingObj : NSObject
@property (nonatomic,strong) NSString *add_person;
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *birth_time;
@property (nonatomic,strong) NSString *brand_name;
@property (nonatomic,strong) NSString *device_code;
@property (nonatomic,strong) NSString *device_id;
@property (nonatomic,strong) NSString *device_model;
@property (nonatomic,strong) NSString *device_type;
@property (nonatomic,strong) NSArray *features;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *location_name;
@property (nonatomic,assign) int pre;
@property (nonatomic,assign) int school_id;


@end
@interface MWBookingFeatureObj : NSObject
@property (nonatomic,assign) int device_id;
@property (nonatomic,assign) int feature_id;
@property (nonatomic,strong) NSString *feature_name;

@property (nonatomic,assign) int feature_time;
@property (nonatomic,assign) int feature_val;
@property (nonatomic,assign) int price;

@end


@interface MWTaskTimeCunt : NSObject
@property (nonatomic,strong) NSString *mTime;
@end

@class MWBaiDuWeatherObj;
@interface MWBaiDuApiBaseObj : NSObject
@property (nonatomic,assign) int errNum;
@property (nonatomic,strong) NSString *errMsg;
@property (nonatomic,assign) id retData;


+ (void)WKGetBaiDuWeather:(NSDictionary *)para block:(void(^)(MWBaiDuApiBaseObj *info,MWBaiDuWeatherObj *mWeatherInfo))block;

@end

@interface MWBaiDuWeatherObj : NSObject
///城市
@property (nonatomic,strong) NSString *city;
///城市拼音
@property (nonatomic,strong) NSString *pinyin;
///城市编码
@property (nonatomic,strong) NSString *citycode;
///日期
@property (nonatomic,strong) NSString *date;
///时间
@property (nonatomic,strong) NSString *time;
///邮编
@property (nonatomic,strong) NSString *postCode;
///经度
@property (nonatomic,strong) NSString *longitude;
///纬度
@property (nonatomic,strong) NSString *latitude;
///海拔
@property (nonatomic,strong) NSString *altitude;
///天气情况
@property (nonatomic,strong) NSString *weather;
///气温
@property (nonatomic,strong) NSString *temp;
///最低气温
@property (nonatomic,strong) NSString *l_tmp;
///最高气温
@property (nonatomic,strong) NSString *h_tmp;
///风向
@property (nonatomic,strong) NSString *WD;
///风力
@property (nonatomic,strong) NSString *WS;
///日出时间
@property (nonatomic,strong) NSString *sunrise;
///日落时间
@property (nonatomic,strong) NSString *sunset;
///
@end

