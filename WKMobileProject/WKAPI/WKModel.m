//
//  WKModel.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/31.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKModel.h"

@implementation WKBaseInfo

/**
 返回错误
 
 @param error 错误
 @return 返回baseinfo
 */
+(WKBaseInfo *)infoWithError:(NSError *)error{
    WKBaseInfo *info = [[WKBaseInfo alloc] init];
    NSString *des = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    if (des.length > 0)
        info.msg = des;
    else
        info.msg = @"网络请示失败，请检查网络";
    info.status = kRetCodeError;
    return info;
}

/**
 返回错误信息
 
 @param errMsg 信息
 @return 返回baseinfo
 */
+(WKBaseInfo *)infoWithErrorMessage:(NSString *)errMsg{
    WKBaseInfo *info = [[WKBaseInfo alloc] init];
    info.msg       = errMsg;
    info.status = kRetCodeError;
    return info;
}

/**
 返回成功信息
 
 @param successMsg 信息
 @return 返回baseinfo
 */
+(WKBaseInfo *)infoWithSuccessMessage:(NSString *)successMsg{
    WKBaseInfo *info = [[WKBaseInfo alloc] init];
    info.msg       = successMsg;
    info.status = kRetCodeSucess;
    return info;
}

/**
 需要登录
 
 @param errMsg 错误信息
 @return 返回baseinfo
 */
+(WKBaseInfo *)infoWithReLoginErrorMessage:(NSString *)errMsg{
    WKBaseInfo *info = [[WKBaseInfo alloc] init];
    info.msg       = errMsg.length>0 ? errMsg : @"请登录";
    info.status = kRetCodeNeedLogin;
    return info;
}

/**
 set方法

 @param retCode setcode
 */
- (void)setRetCode:(NSString *)retCode{
    _retCode = retCode;
    if ([retCode isEqualToString:@"3"]){
        MLLog(@"需要登录");
        _status = kRetCodeNeedLogin;
    }else if ([retCode isEqualToString:@"10020"]){
        _status = kRetCodeAPIMaintain;
    }else if ([retCode isEqualToString:@"200"]){
        _status = kRetCodeSucess;
    }
    else if ([retCode isEqualToString:@"10002"]){
        _status = kRetCodeError;
    }else if ([retCode isEqualToString:@"23201"]){
        _status = kRetCodeError;
        _msg = @"没有相关数据！";
    }else{
        _status = kRetCodeIllega;

    }

}
+ (void)WKFindTrainNumber:(NSDictionary *)param block:(void(^)(WKBaseInfo *info,NSArray *list))block{
    

    [[WKHttpRequest shareClient] WKGetDataWithUrl:@"queryByTrainNo" withPara:param block:^(WKBaseInfo *info) {
        if (info.status
            == kRetCodeSucess) {
            
            NSMutableArray *mArr= [NSMutableArray new];
            NSMutableArray *ArrTemp= [NSMutableArray new];

            if ([info.result isKindOfClass:[NSArray class]]) {
                [mArr addObjectsFromArray:info.result];
            }
            for (int i =0; i<mArr.count; i++) {
                [ArrTemp addObject:[WKTrainName yy_modelWithDictionary:mArr [i]]];
            }
            
            block(info,ArrTemp);
        }else{
            block(info,nil);
        }
    }];

}

@end

@implementation WKUser : NSObject

static WKUser *g_user = nil;

+ (WKUser *)currentUser{
    if (g_user) {
        return g_user;
    }
    @synchronized(self) {
        if (!g_user) {
            g_user = [WKUser loadUserInfo];
        }
        return g_user;
    }
}
+(void)saveUserInfo:(id)info
{
    info = [Util delNUll:info];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:info forKey:@"userInfo"];
    [def synchronize];
}
+ (WKUser *)loadUserInfo{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"userInfo"];
    if( dat )
        {
        WKUser* tu = [WKUser yy_modelWithDictionary:dat];
        return tu;
        }
    return nil;
}
+(NSDictionary*)loadUserJson
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:@"userInfo"];
}

+(void)cleanUserInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:nil forKey:@"userInfo"];
    [def synchronize];
}

//判断是否需要登录
+(BOOL)isNeedLogin
{
    return [WKUser currentUser] == nil;
}
+ (void)WKRegistWechatOpenId:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/user.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info);
        }else{
            block(info);
        }
    }];
    
}
/**
 手机号码登录
 
 @param param 参数
 @param block 返回信息
 */
+ (void)WKUserLoginWithMobile:(NSDictionary *)param block:(void(^)(WKBaseInfo *info))block{
    
    MLLog(@"参数是：%@",param);
    
    [[WKHttpRequest shareClient] WKGetDataWithUrl:@"/login/login.php" withPara:param block:^(WKBaseInfo *info) {
        if (info.status
            == kRetCodeSucess) {
            
          
            block(info);
        }else{
            block(info);
        }
    }];
}
/**
 验证码登录
 
 @param param 参数
 @param block 返回信息
 */
+ (void)WKVeryfyLogin:(NSDictionary *)param block:(void(^)(WKBaseInfo *info))block{
    MLLog(@"参数是：%@",param);
    
    [[WKHttpRequest shareClient] WKGetDataWithUrl:@"/login/code_login.php" withPara:param block:^(WKBaseInfo *info) {
        if (info.status
            == kRetCodeSucess) {
            
            
            block(info);
        }else{
            block(info);
        }
    }];
}
/**
 获取验证码
 
 @param param 参数
 @param block 返回信息
 */
+ (void)WKGetVeryfyCode:(NSDictionary *)param block:(void(^)(WKBaseInfo *info))block{
    MLLog(@"参数是：%@",param);
    
    [[WKHttpRequest shareClient] WKGetDataWithUrl:@"/code/login_code.php" withPara:param block:^(WKBaseInfo *info) {
        if (info.status
            == kRetCodeSucess) {
            
            
            block(info);
        }else{
            block(info);
        }
    }];
}
/**
 注册
 
 @param param 参数
 @param block 返回信息
 */
+ (void)WKUserRegist:(NSDictionary *)param block:(void(^)(WKBaseInfo *info))block{
    MLLog(@"参数是：%@",param);
    
    [[WKHttpRequest shareClient] WKGetDataWithUrl:@"/login/register.php" withPara:param block:^(WKBaseInfo *info) {
        if (info.status
            == kRetCodeSucess) {
            
            
            block(info);
        }else{
            block(info);
        }
    }];
}
@end
@implementation WKModel : NSObject

@end
@implementation body

@end
@implementation WKTrainName

@end

@implementation WKFunc


@end

@implementation WKHome  : NSObject
/**
 获取首页数据
 
 @param para 参数
 @param block 返回信息
 */
+ (void)WKGetHomeList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mBannerArr,NSArray *mTuijianArr,NSArray *mActivityArr))block{

    MLLog(@"参数是：%@",para);
    
    [[WKHttpRequest shareClient] MWPostWithUrl:@"controller/index/index.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            
            NSMutableArray *mBARR = [NSMutableArray new];
            NSMutableArray *mTARR = [NSMutableArray new];
            NSMutableArray *mAARR = [NSMutableArray new];

            if ([info.data isKindOfClass:[NSDictionary class]]) {
                if ([[info.data objectForKey:@"banner"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dic in [info.data objectForKey:@"banner"]) {
                        [mBARR addObject:[WKHome yy_modelWithDictionary:dic]];
                    }
                }
                if ([[info.data objectForKey:@"recommend"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dic in [info.data objectForKey:@"recommend"]) {
                        [mTARR addObject:[WKHome yy_modelWithDictionary:dic]];
                    }
                }
                if ([[info.data objectForKey:@"activity"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dic in [info.data objectForKey:@"activity"]) {
                        [mAARR addObject:[WKHome yy_modelWithDictionary:dic]];
                    }
                }
            
                
            }
            
            block(info,mBARR,mTARR,mAARR);
        }else{
            block(info,nil,nil,nil);
        }
    }];
    
}
@end

@implementation WKBanner  : NSObject
@end

@implementation WKNews  : NSObject

/**
 获取聚合新闻数据
 
 @param para 参数
 @param block 返回信息
 */
+ (void)WKGetJuheNewsList:(NSDictionary *)para block:(void(^)(WKJUHEObj *info,NSArray *mArr))block{
    
    MLLog(@"参数是：%@",para);
    //
    //    [[WKHttpRequest initJUHEApiClient] WKJHGetDataWithUrl:@"/toutiao/index" withPara:para block:^(WKJUHEObj *jhinfo) {
    //        if (jhinfo.status
    //            == kRetCodeSucess) {
    //
    //
    //            block(jhinfo,nil);
    //        }else{
    //            block(jhinfo,nil);
    //        }
    //    }];
    
    [[WKHttpRequest initJUHEApiClient] WKJHGetDataWithUrl:@"/toutiao/index" withPara:para block:^(WKJUHEObj *info) {
        if (info.error_code == 0) {
            
            NSMutableArray *mTempArr = [NSMutableArray new];
            if ([info.result isKindOfClass:[NSDictionary class]]) {
                NSArray *mListArr = [info.result objectForKey:@"data"];
                if (mListArr.count > 0) {
                    for (NSDictionary *dic in mListArr) {
                        [mTempArr addObject:[WKNews yy_modelWithDictionary:dic]];
                    }
                }
            }
            
            block(info,mTempArr);
        }else{
            block(info,nil);
        }
    }];
    
}
+ (void)WKGetWeather:(NSDictionary *)para block:(void(^)(WKBaseInfo *info))block{
    [[WKHttpRequest shareClient] WKGetDataWithUrl:@"v1/weather/ip" withPara:para block:^(WKBaseInfo *info) {
        if (info.status == kRetCodeSucess) {
            
            block(info);
        }else{
            block(info);
        }
    }];
    
}

@end

@implementation WKJUHEObj  : NSObject

@end
@implementation WKWechatObj  : NSObject
+ (void)WKGetWechat:(NSDictionary *)para block:(void(^)(WKBaseInfo *info,NSArray *mArr))block{
    [[WKHttpRequest shareClient] WKGetDataWithUrl:@"wx/article/search" withPara:para block:^(WKBaseInfo *info) {
        if (info.status == 0) {
            NSMutableArray *mTempArr = [NSMutableArray new];

            if ([info.result isKindOfClass:[NSDictionary class]]) {
                NSArray *mList = [info.result objectForKey:@"list"];
                if (mList.count>0) {
                    for (NSDictionary *dic in mList) {
                        [mTempArr addObject:[WKWechatObj yy_modelWithDictionary:dic]];
                    }
                }
            }
  
            block(info,mTempArr);
        }else{
            block(info,nil);
        }
    }];
}
@end


@implementation MWBaseObj

/**
 返回错误
 
 @param error 错误
 @return 返回baseinfo
 */
+(MWBaseObj *)infoWithError:(NSError *)error{
    MWBaseObj *info = [[MWBaseObj alloc] init];
    NSString *des = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    if (des.length > 0)
        info.err_msg = des;
    else
        info.err_msg = @"网络请示失败，请检查网络";
    info.err_code = kRetCodeError;
    return info;
}

/**
 返回错误信息
 
 @param errMsg 信息
 @return 返回baseinfo
 */
+(MWBaseObj *)infoWithErrorMessage:(NSString *)errMsg{
    MWBaseObj *info = [[MWBaseObj alloc] init];
    info.err_msg       = errMsg;
    info.err_code = kRetCodeError;
    return info;
}

/**
 返回成功信息
 
 @param successMsg 信息
 @return 返回baseinfo
 */
+(MWBaseObj *)infoWithSuccessMessage:(NSString *)successMsg{
    MWBaseObj *info = [[MWBaseObj alloc] init];
    info.err_msg       = successMsg;
    info.err_code = kRetCodeSucess;
    return info;
}

/**
 需要登录
 
 @param errMsg 错误信息
 @return 返回baseinfo
 */
+(MWBaseObj *)infoWithReLoginErrorMessage:(NSString *)errMsg{
    MWBaseObj *info = [[MWBaseObj alloc] init];
    info.err_msg       = errMsg.length>0 ? errMsg : @"请登录";
    info.err_code = kRetCodeNeedLogin;
    return info;
}
/**
 手机号码登录
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWLoginWithPhone:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/login/login.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            if ([info.data isKindOfClass:[NSDictionary class]]) {

                [WKUser saveUserInfo:info.data];

                [[NSNotificationCenter defaultCenter] postNotificationName:KAppFetchJPUSHService object:nil];
                block(info);
            }else{
                block(info);
            }
        }else{
            block(info);
        }
    }];
}
/**
 获取验证码
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetMobileVeryfyCode:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/code/login_code.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info);
        }else{
            block(info);
        }
    }];
    
}
/**
 验证码登录
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWVeryfyCodeLogin:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/login/code_login.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            if ([info.data isKindOfClass:[NSDictionary class]]) {
                
                [WKUser saveUserInfo:info.data];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KAppFetchJPUSHService object:nil];
                block(info);
            }else{
                block(info);
            }
        }else{
            block(info);
        }
    }];
}
/**
 注册
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWRegist:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/login/register.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info);
        }else{
            block(info);
        }
    }];
    
}
/**
 获取学校列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetSchoolList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block{
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/school.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info,nil);
        }else{
            block(info,nil);
        }
    }];
}
/**
 查询学校
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFindSchoolList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr,MWSchoolInfo *mSchool))block{
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"debug/tj.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 1) {
            
            NSMutableArray *mTempArr = [NSMutableArray new];
            MWSchoolInfo *mSchoolInfo = [MWSchoolInfo new];
            mSchoolInfo.sum_money = [NSString stringWithFormat:@"%@",[info.data objectForKey:@"sum_money"]];

            if ([info.data isKindOfClass:[NSDictionary class]]) {
                for (NSDictionary *dic in [info.data objectForKey:@"arr"]) {
                    mSchoolInfo.school_name = [dic objectForKey:@"school_name"];
                    [mTempArr addObject:[MWDeviceInfo yy_modelWithDictionary:dic]];
                }
            }
      
            block(info,mTempArr,mSchoolInfo);
        }else{
            block(info,nil,nil);
        }
    }];
}
/**
 查询洗衣机
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFindDeviceList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block{
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/add_wash.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info,nil);
        }else{
            block(info,nil);
        }
    }];
}
/**
 查询洗衣机信息
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFindDeviceInfo:(NSDictionary *)para block:(void(^)(MWBaseObj *info,MWBookingObj *mArr))block{
    MLLog(@"参数是：%@",para);

    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/wash.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            if ([info.data isKindOfClass:[NSDictionary class]]) {
                block(info,[MWBookingObj yy_modelWithDictionary:info.data]);
            }else{
                block(info,nil);

            }
        }else{
            block(info,nil);
        }
    }];
}
/**
 添加功能
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWAddDeviceFunc:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/add_wash.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info);
        }else{
            block(info);
        }
    }];
}
/**
 查询任务
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFindTaskList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block{
    MLLog(@"参数是：%@",para);

    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/device_tasks.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info,nil);
        }else{
            block(info,nil);
        }
    }];
}

/**
 操作洗衣机
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWControlDevice:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/device_tasks.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info);
        }else{
            block(info);
        }
    }];
}
/**
 获取洗衣机状态
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetDeviceStatus:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/device_run_status.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info);
        }else{
            block(info);
        }
    }];
}
/**
 编号洗衣获取deviceCode
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWWashToCode:(NSMutableDictionary *)para block:(void(^)(MWBaseObj *info,MWDeviceCode *mDeviceCode))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"qr/" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info,[MWDeviceCode yy_modelWithDictionary:info.data]);
        }else{
            block(info,nil);
        }
    }];
//    [[WKHttpRequest initClient] WKMWGetDataWithUrl:@"qr/" withPara:para block:^(MWBaseObj *info) {
//        if (info.err_code == 0) {
//            block(info,[MWDeviceCode yy_modelWithDictionary:info.data]);
//        }else{
//            block(info,nil);
//        }
//    }];

}

#pragma mark----****----获取我的任务列表
/**
 获取我的任务列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetTaskList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mBannerArr,NSArray *mList))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/task_member/index.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mBannerA = [NSMutableArray new];
            NSMutableArray *mArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSDictionary class]]) {
                for (NSDictionary *dic in [info.data objectForKey:@"banner_list"]) {
                    [mBannerA addObject:[WKHome yy_modelWithDictionary:dic]];
                }
                if ([[info.data objectForKey:@"task_list"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *mdic in [info.data objectForKey:@"task_list"]) {
                        [mArr addObject:[MWTaskObj yy_modelWithDictionary:mdic]];
                    }
                }else if([[info.data objectForKey:@"task_list"] isKindOfClass:[NSDictionary class]]){
                    [mArr addObject:[MWTaskObj yy_modelWithDictionary:[info.data objectForKey:@"task_list"]]];
                }
           
            }
            
            block(info,mBannerA,mArr);
        }else{
            block(info,nil,nil);
        }
    }];
}
/**
 领取任务
 
 @param para 参数
 @param block 返回值
 */
+(void)MWFetchTask:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    MLLog(@"参数是：%@",para);                           
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/take_member/add_task.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info);
        }else{
            block(info);
        }
    }];
}
#pragma mark----****----获取活动列表
/**
 获取活动列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFetchActivityList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/activity/index.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mList = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in info.data) {
                    [mList addObject:[WKHome yy_modelWithDictionary:dic]];
                }
            }
            block(info,mList);
        }else{
            block(info,nil);
        }
    }];
}
#pragma mark----****----获取发现首页数据
/**
 获取发现首页数据
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetFindList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mBannerArr,NSArray *mList))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/func/index.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mBArr = [NSMutableArray new];
            NSMutableArray *mLArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSDictionary class]]) {
                if ([[info.data objectForKey:@"banner_list"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dic in [info.data objectForKey:@"banner_list"]) {
                        [mBArr addObject:[WKHome yy_modelWithDictionary:dic]];
                    }
                }
                if ([[info.data objectForKey:@"func_list"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dic in [info.data objectForKey:@"func_list"]) {
                        [mLArr addObject:[MWDiscoveryObj yy_modelWithDictionary:dic]];
                    }
                }
               
            }
            block(info,mBArr,mLArr);
        }else{
            block(info,nil,nil);
        }
    }];
}
#pragma mark----****----获取玩游戏列表
/**
 获取玩游戏列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWFetchGameList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/game/index.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mLArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in info.data) {
                    [mLArr addObject:[MWGameObj yy_modelWithDictionary:dic]];
                }
            }
            
            block(info,mLArr);
        }else{
            block(info,nil);
        }
    }];
}
#pragma mark----****----获取消息列表
/**
 获取消息列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetMessageList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/member/member_message.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mLArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in info.data) {
                    [mLArr addObject:[MWMessageObj yy_modelWithDictionary:dic]];
                }
            }
            
            block(info,mLArr);
        }else{
            block(info,nil);
        }
    }];
}
#pragma mark----****----用户签到
/**
 用户签到
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWUserSign:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/member/member_report.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            
            block(info);
        }else{
            block(info);
        }
    }];
}
/**
 更新用户信息
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWReFreshUserInfo:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mActArr,BOOL mSign))block{
    MLLog(@"参数是：%@",para);
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/member/personal.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            BOOL mS = false;
            if ([info.data isKindOfClass:[NSDictionary class]]) {
                if ([[info.data objectForKey:@"member_list"] isKindOfClass:[NSDictionary class]]) {
                    [WKUser saveUserInfo:[info.data objectForKey:@"member_list"]];
                }
                if ([info.data objectForKey:@"banner_list"] != nil) {
                    if ([[info.data objectForKey:@"banner_list"] isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *dic in [info.data objectForKey:@"banner_list"]) {
                            [mTempArr addObject:[WKHome yy_modelWithDictionary:dic]];
                        }
                    }
                }
                
                if ([[info.data objectForKey:@"typeid"] isKindOfClass:[NSNumber class]]) {
                    int mNumber = [[info.data objectForKey:@"typeid"] intValue];
                    if (mNumber == 0) {
                        mS = NO;
                    }else{
                        mS = YES;

                    }
                }
               
                block(info,mTempArr,mS);
            }else{
                block(info,mTempArr,NO);
            }
        }else{
            block(info,nil,NO);
        }
    }];
}
/**
 帮助中心和联系我们
 
 @param para 参数
 @param mtype 类型
 @param block 返回值
 */
+ (void)MWGetHelpCenter:(NSDictionary *)para andType:(int)mtype block:(void(^)(MWBaseObj *info,NSArray *mArr,NSArray *mList))block{

    MLLog(@"参数是：%@",para);
    
    NSString *mUrl = nil;
    
    if (mtype == 2) {
        mUrl = @"controller/help/help_list.php";
    }else{
        mUrl = @"controller/contact/contact_us.php";
    }
    
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:mUrl withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            if (mtype == 1) {
                if ([info.data isKindOfClass:[NSDictionary class]]) {
            
                        if ([[info.data objectForKey:@"contact_us_list"] isKindOfClass:[NSArray class]]) {
                            for (NSDictionary *dic in [info.data objectForKey:@"contact_us_list"]) {
                                [mTempArr addObject:[MWConntactUsObj yy_modelWithDictionary:dic]];
                            }
                        }

                    block(info,nil,mTempArr);
                }else{
                    block(info,nil,mTempArr);
                }
            }else{
                if ([info.data isKindOfClass:[NSDictionary class]]) {
                    
                    if ([[info.data objectForKey:@"h_list"] isKindOfClass:[NSDictionary class]]) {
                        [mTempArr addObject:[MWHelpCenterObj yy_modelWithDictionary:[info.data objectForKey:@"h_list"]]];
                        
                    }
                    
                    block(info,nil,mTempArr);
                }else{
                    block(info,nil,mTempArr);
                }
            }
        }else{
            block(info,nil,nil);
        }
    }];
}
#pragma mark----****----获取加入我们
/**
 获取加入我们
 
 @param block 返回值
 */
+ (void)MWGetJoinUs:(void(^)(MWBaseObj *info,NSArray *mArr))block{
 
    
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/join/join_list.php" withPara:@{} block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSDictionary class]]) {
                
                [mTempArr addObject:[MWJoinUsObj yy_modelWithDictionary:info.data]];
                
                block(info,mTempArr);
            }else{
                block(info,mTempArr);
            }
        }else{
            block(info,nil);
        }
    }];
}
#pragma mark----****----申请加入我们
/**
 申请加入我们
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWApplyJoinUs:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{
    MLLog(@"参数是：%@",para);
    
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/join/join_order.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
    
            block(info);

        }else{
            block(info);
        }
    }];
}
#pragma mark----****----获取金币列表
/**
 获取金币列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetGoldHistoryList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block{
    MLLog(@"参数是：%@",para);
    
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/gold/index.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in info.data) {
                    [mTempArr addObject:[MWGoldListObj yy_modelWithDictionary:dic]];
                }
            }
            block(info,mTempArr);
            
        }else{
            block(info,nil);
        }
    }];
}
#pragma mark----****----获取洗衣机订单列表
/**
 获取洗衣机订单列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetMyWashOrderList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block{
    MLLog(@"参数是：%@",para);
    
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/member/member_wash_order.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in info.data) {
                    [mTempArr addObject:[MWWashOrderObj yy_modelWithDictionary:dic]];
                }
            }
            block(info,mTempArr);
            
        }else{
            block(info,nil);
        }
    }];
}
#pragma mark----****---- 获取我的任务订单列表
/**
 获取我的任务订单列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGETMyTaskOrderList:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block{
    MLLog(@"参数是：%@",para);
    
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/take_member/task_record.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in info.data) {
                    [mTempArr addObject:[MWWashOrderObj yy_modelWithDictionary:dic]];
                }
            }
            block(info,mTempArr);
            
        }else{
            block(info,nil);
        }
    }];
}
#pragma mark----****----  获取我的财富值
/**
 获取我的财富值
 
 @param para 参数
 @param block 返回值
 */
+ (void)MWGetMyWealth:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mList))block{
    MLLog(@"参数是：%@",para);
    
    [[WKHttpRequest initLocalApiclient] MWPostWithUrl:@"controller/riches/riches_list.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            if ([info.data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in info.data) {
                    [mTempArr addObject:[MWWashOrderObj yy_modelWithDictionary:dic]];
                }
            }
            block(info,mTempArr);
            
        }else{
            block(info,nil);
        }
    }];
    
}
@end

@implementation MWDeviceInfo
@end
@implementation MWSchoolInfo
@end

@implementation MWDeviceCode
@end

@implementation MWBookingObj
+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"features":@"MWBookingFeatureObj"};
}
@end
@implementation MWBookingFeatureObj
@end


@implementation MWTaskTimeCunt
@end

@implementation MWBaiDuApiBaseObj
+ (void)WKGetBaiDuWeather:(NSString *)mCity andJingdu:(NSString *)mJ andWeidu:(NSString *)mW block:(void(^)(MWBaiDuApiBaseObj *info))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mCity forKey:@"city"];

    MLLog(@"参数是：%@",para);
    
//    [[WKHttpRequest initBaiDuAPI] WKBaiDuGetDataWithUrl:@"weather/query" withPara:para block:^(MWBaiDuApiBaseObj *info) {
//        if (info.status == 0) {
//            block(info,[MWBaiDuWeatherObj yy_modelWithDictionary:info.result]);
//        }else{
//            block(info,nil);
//        }
//    }];
    
    NSString *appcode = @"e91dafba851d476b9c74160491d8588d";
    NSString *host = @"http://jisutqybmf.market.alicloudapi.com";
    NSString *path = @"/weather/query";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?city=%@",mCity];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       MLLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       
                                                       MWBaiDuApiBaseObj *info = [MWBaiDuApiBaseObj yy_modelWithJSON:[Util stringToDictionary:bodyString]];
                                                       block(info);
                                                       //打印应答中的body
                                                       MLLog(@"Response body: %@" , info);
                                                   }];
    
    [task resume];
    
}

@end

@implementation MWBaiDuWeatherObj

@end


@implementation MWTaskObj

@end
@implementation MWDiscoveryObj

@end

@implementation MWBuyGold

@end

@implementation MWGameObj

@end
@implementation MWLocationInfo

@end

@implementation MWMessageObj

@end

@implementation MWJoinUsObj

@end
@implementation MWConntactUsObj

@end
@implementation MWHelpCenterObj

@end
@implementation MWGoldListObj

@end

@implementation MWWashOrderObj

@end
