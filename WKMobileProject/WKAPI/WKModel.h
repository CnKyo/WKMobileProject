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


@property (nonatomic, strong) NSString *            password;
@property (nonatomic, strong) NSString *            verifycode;
@property (nonatomic, strong) NSString *            recommender_mobile;

@property (nonatomic, strong) NSString *            token;
@property (nonatomic, strong) NSString *            mobile;

@property (nonatomic,assign) NSString *user_id;

@property (nonatomic, strong) NSString *            open_id;                ///
@property (nonatomic, strong) NSString *            photo;                  ///
@property (nonatomic, strong) NSString *            jpush;                  ///
@property (nonatomic, strong) NSString *            app_v;                  ///
@property (nonatomic, strong) NSString *            sys_v;                  ///
@property (nonatomic, strong) NSString *            sys_t;                  ///

@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *headimgurl;
@property (nonatomic, strong) NSString *            nickname;              ///
@property (nonatomic, strong) NSString *            regip;              ///
@property (nonatomic, strong) NSString *            school_id;                  ///
@property (nonatomic, strong) NSString *            wxoid;                  ///

///登录用户返回信息
@property (nonatomic, strong) NSString *            ISP;                  ///
@property (nonatomic, strong) NSString *            add_time;                  ///
@property (nonatomic, strong) NSString *            appid;                  ///
@property (nonatomic, strong) NSString *            appname;                  ///
@property (nonatomic, strong) NSString *            badges;                  ///
@property (nonatomic, strong) NSString *            certificates;                  ///
@property (nonatomic, strong) NSString *            cityid;                  ///
@property (nonatomic, strong) NSString *            consume;                  ///
@property (nonatomic, strong) NSString *            credit_detail;                  ///
@property (nonatomic, strong) NSString *            credits;                  ///
@property (nonatomic, strong) NSString *            email;                  ///
@property (nonatomic, strong) NSString *            final_login_time;                  ///

@property (nonatomic, strong) NSString *            frozenCredit;                  ///
@property (nonatomic, strong) NSString *            gid;                  ///
@property (nonatomic, strong) NSString *            gold;                  ///
@property (nonatomic, strong) NSString *            grade_credits;                  ///
@property (nonatomic, strong) NSString *            gradeid;                  ///
@property (nonatomic, strong) NSString *            groupexpiry;                  ///
@property (nonatomic, strong) NSString *            guid;                  ///
@property (nonatomic, strong) NSString *            hash;                  ///
@property (nonatomic, strong) NSString *            identifier;                  ///
@property (nonatomic, strong) NSString *            im_token;                  ///
@property (nonatomic, strong) NSString *            inviteid;                  ///
@property (nonatomic, strong) NSString *            ip;                  ///
@property (nonatomic, strong) NSString *            isVerify;                  ///
@property (nonatomic, strong) NSString *            is_bind_paypwd;                  ///
@property (nonatomic, strong) NSString *            jobid;                  ///
@property (nonatomic, strong) NSString *            jpush_id;                  ///
@property (nonatomic, strong) NSString *            last_login_device;                  ///
@property (nonatomic, strong) NSString *            last_login_device_type;                  ///
@property (nonatomic, strong) NSString *            last_login_time;                  ///
@property (nonatomic, strong) NSString *            last_login_udid;                  ///
@property (nonatomic, strong) NSString *            member_id;                  ///
@property (nonatomic, strong) NSString *            member_name;                  ///
@property (nonatomic, strong) NSString *            myData;                  ///
@property (nonatomic, strong) NSString *            nick_name;                  ///
              ///
///
///
@property (nonatomic, strong) NSString *            paypassword;                  ///
@property (nonatomic, strong) NSString *            reg_device_token;                  ///
@property (nonatomic, strong) NSString *            reg_udid;                  ///
@property (nonatomic, strong) NSString *            rewards;                  ///
@property (nonatomic, strong) NSString *            salt;                  ///
@property (nonatomic, strong) NSString *            school_name;                  ///

@property (nonatomic, strong) NSString *            schoolid;                  ///
@property (nonatomic, strong) NSString *            signature;                  ///
@property (nonatomic, strong) NSString *            status;                  ///
@property (nonatomic, strong) NSString *            type;                  ///
@property (nonatomic, strong) NSString *            type_name;                  ///
@property (nonatomic, strong) NSString *            update_time;                  ///
@property (nonatomic, strong) NSString *            user_img;                  ///
@property (nonatomic, strong) NSString *            user_name;                  ///
















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

@class MWBaseObj;
@class WKBanner;
@interface WKHome  : NSObject
///0：首页banner，1：推荐，2：活动
@property (nonatomic,assign) NSNumber *banner_type;
///标题
@property (nonatomic,strong) NSString *banner_title;
///图片url
@property (nonatomic,strong) NSString *banner_img;
///跳转url
@property (nonatomic,strong) NSString *banner_skip_content;

@property (nonatomic,strong) NSString *add_person;
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *banner_content;
@property (nonatomic,strong) NSString *banner_skip_type;
@property (nonatomic,strong) NSString *banner_status;
@property (nonatomic,strong) NSString *isshow;
@property (nonatomic,strong) NSString *sort;
@property (nonatomic,strong) NSString *banner_id;




/**
 获取首页数据

 @param para 参数
 @param block 返回信息
 */
+ (void)WKGetHomeList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mBannerArr,NSArray *mTuijianArr,NSArray *mActivityArr))block;

@end
@interface WKBanner  : NSObject
///0:顶部banner。 1：推荐。2:活动。
@property (nonatomic,assign) int type;

@property (nonatomic,strong) NSArray *List;

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
@class MWTaskObj;

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
 手机号码登录

 @param para 参数
 @param block 返回值
 */
+ (void)MWLoginWithPhone:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;

/**
 获取验证码

 @param para 参数
 @param block 返回值i
 */
+ (void)MWGetMobileVeryfyCode:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;

/**
 验证码登录

 @param para 参数
 @param block 返回值
 */
+ (void)MWVeryfyCodeLogin:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;

/**
 注册

 @param para 参数
 @param block 返回值
 */
+ (void)MWRegist:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;
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


#pragma mark----****----获取我的任务列表
/**
 获取我的任务列表

 @param para 参数
 @param block 返回值
 */
+ (void)MWGetTaskList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mBannerArr,NSArray *mList))block;
#pragma mark----****----领取任务
/**
 领取任务

 @param para 参数
 @param block 返回值
 */
+(void)MWFetchTask:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;

#pragma mark----****----获取活动列表
/**
 获取活动列表

 @param para 参数
 @param block 返回值
 */
+ (void)MWFetchActivityList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block;

#pragma mark----****----获取发现首页数据
/**
 获取发现首页数据

 @param para 参数
 @param block 返回值
 */
+ (void)MWGetFindList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mBannerArr,NSArray *mList))block;
#pragma mark----****----获取玩游戏列表
/**
 获取玩游戏列表

 @param para 参数
 @param block 返回值
 */
+ (void)MWFetchGameList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block;
#pragma mark----****----获取消息列表
/**
 获取消息列表和读取消息

 @param para 参数
 @param block 返回值
 */
+ (void)MWGetMessageList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block;
#pragma mark----****----用户签到
/**
 用户签到

 @param para 参数
 @param block 返回值
 */
+ (void)MWUserSign:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;
#pragma mark----****----更新用户信息
/**
 更新用户信息

 @param para 参数
 @param block 返回值
 */
+ (void)MWReFreshUserInfo:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mActArr,BOOL mSign))block;
#pragma mark----****----帮助中心和联系我们
/**
 帮助中心和联系我们

 @param para 参数
 @param mtype 类型
 @param block 返回值
 */
+ (void)MWGetHelpCenter:(NSDictionary *)para andType:(int)mtype block:(void(^)(MWBaseObj *info,NSArray *mArr,NSArray *mList))block;
#pragma mark----****----获取加入我们
/**
 获取加入我们

 @param block 返回值
 */
+ (void)MWGetJoinUs:(void(^)(MWBaseObj *info,NSArray *mArr))block;
#pragma mark----****----申请加入我们
/**
 申请加入我们

 @param para 参数
 @param block 返回值
 */
+ (void)MWApplyJoinUs:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block;
#pragma mark----****----获取金币列表
/**
 获取金币列表

 @param para 参数
 @param block 返回值
 */
+ (void)MWGetGoldHistoryList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block;
#pragma mark----****----获取洗衣机订单列表
/**
 获取洗衣机订单列表

 @param para 参数
 @param block 返回值
 */
+ (void)MWGetMyWashOrderList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block;
#pragma mark----****---- 获取我的任务订单列表
/**
 获取我的任务订单列表

 @param para 参数
 @param block 返回值
 */
+ (void)MWGETMyTaskOrderList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block;
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
@property (nonatomic,assign) int status;
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,assign) id result;


+ (void)WKGetBaiDuWeather:(NSString *)mCity andJingdu:(NSString *)mJ andWeidu:(NSString *)mW block:(void(^)(MWBaiDuApiBaseObj *info))block;

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


@interface MWTaskObj : NSObject
@property (nonatomic,strong) NSString *add_person;
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *allowed_num;
@property (nonatomic,strong) NSString *complete_time;
@property (nonatomic,strong) NSString *experience;
@property (nonatomic,strong) NSString *isshow;
@property (nonatomic,strong) NSString *istop;
@property (nonatomic,strong) NSString *reward_riches;
@property (nonatomic,strong) NSString *reward_time;
@property (nonatomic,strong) NSString *task_add_time;
@property (nonatomic,strong) NSString *task_choose_num;
@property (nonatomic,strong) NSString *task_complete_rate;
@property (nonatomic,strong) NSString *task_describe;
@property (nonatomic,strong) NSString *task_end_time;
@property (nonatomic,strong) NSString *task_id;
@property (nonatomic,strong) NSString *task_image;
@property (nonatomic,strong) NSString *task_leave_num;
@property (nonatomic,strong) NSString *task_notices;
@property (nonatomic,strong) NSString *task_price;
@property (nonatomic,strong) NSString *task_status;
@property (nonatomic,strong) NSString *task_step;
@property (nonatomic,strong) NSString *task_title;
@property (nonatomic,strong) NSString *task_total_num;
@property (nonatomic,strong) NSString *task_type;

@end

@interface MWDiscoveryObj : NSObject
@property (nonatomic,strong) NSString *add_person;
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *func_img;
@property (nonatomic,strong) NSString *func_skip_content;
@property (nonatomic,strong) NSString *func_title;
@property (nonatomic,strong) NSString *func_type;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *sort;

@end

///买金币
@interface MWBuyGold : NSObject
///数量
@property (nonatomic,strong) NSString *mNum;
///价格
@property (nonatomic,assign) int mPrice;
///支付方式1:微信。2:支付宝。
@property (nonatomic,assign) NSInteger mPayType;

@end



@interface MWGameObj : NSObject

@property (nonatomic,strong) NSString *add_person;
@property (nonatomic,assign) int add_time;
@property (nonatomic,strong) NSString *game_id;
@property (nonatomic,strong) NSString *game_logo;
@property (nonatomic,strong) NSString *game_name;
@property (nonatomic,strong) NSString *game_status;
@property (nonatomic,strong) NSString *game_type;
@property (nonatomic,strong) NSString *game_url;
@property (nonatomic,assign) int pay_coin_num;

@end
///定位对象
@interface MWLocationInfo : NSObject

@property (nonatomic,strong) NSArray *detail;
@property (nonatomic,strong) NSString *Street;
@property (nonatomic,strong) NSString *Country;
@property (nonatomic,strong) NSString *jing;
@property (nonatomic,strong) NSString *wei;
@property (nonatomic,strong) NSString *shi;
@property (nonatomic,strong) NSString *xian;

@end

@interface MWMessageObj : NSObject

@property (nonatomic,assign) int add_time;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *income_expenditure;
@property (nonatomic,strong) NSString *member_id;
@property (nonatomic,strong) NSString *message_id;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *read_time;
@property (nonatomic,strong) NSString *riches_arrive_status;
@property (nonatomic,strong) NSString *stauts;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *typeid;


@end
@interface MWJoinUsObj : NSObject
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *join_id;
@property (nonatomic,strong) NSString *join_img;
@property (nonatomic,strong) NSString *join_mode;
@property (nonatomic,strong) NSString *join_status;
@property (nonatomic,strong) NSString *requirement;
@property (nonatomic,strong) NSString *task_or_active;
@property (nonatomic,strong) NSString *title;

///加入我们表单数据
@property (nonatomic,strong) NSString *mName;
@property (nonatomic,strong) NSString *mPhone;
@property (nonatomic,strong) NSString *mAddress;
@property (nonatomic,strong) NSString *mSex;


@end
@interface MWConntactUsObj : NSObject
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *admin_id;
@property (nonatomic,strong) NSString *contact_us_id;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *us_title;


@end

@interface MWHelpCenterObj : NSObject
@property (nonatomic,strong) NSString *add_person;
@property (nonatomic,strong) NSString *help_id;
@property (nonatomic,strong) NSString *help_logo;
@property (nonatomic,strong) NSString *help_number;
@property (nonatomic,strong) NSString *help_title;
@property (nonatomic,strong) NSString *help_type;


@end

@interface MWGoldListObj : NSObject
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *income_expenditure;
@property (nonatomic,strong) NSString *member_id;
@property (nonatomic,strong) NSString *message_id;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *read_time;
@property (nonatomic,strong) NSString *riches_arrive_status;
@property (nonatomic,strong) NSString *stauts;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *typeid;


@end

@interface MWWashOrderObj : NSObject
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *device_id;
@property (nonatomic,strong) NSString *location_name;
@property (nonatomic,strong) NSString *member_id;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *order_no;
@property (nonatomic,strong) NSString *order_pay_type;
@property (nonatomic,strong) NSString *order_price;
@property (nonatomic,strong) NSString *order_type;
@property (nonatomic,strong) NSString *pay_status;
@property (nonatomic,strong) NSString *pay_time;
@property (nonatomic,strong) NSString *school_id;
@property (nonatomic,strong) NSString *wash_feature;
@property (nonatomic,strong) NSString *wash_feature_name;
@property (nonatomic,strong) NSString *wash_id;
@property (nonatomic,strong) NSString *wash_remark;
@property (nonatomic,strong) NSString *wash_time;

@end
