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
+ (void)WKGetHomeList:(NSDictionary *)para block:(void(^)(WKBaseInfo *info,NSArray *mArr))block{
    
    MLLog(@"参数是：%@",para);
    
    [[WKHttpRequest shareClient] WKGetDataWithUrl:@"/index/index.php" withPara:para block:^(WKBaseInfo *info) {
        if (info.status
            == kRetCodeSucess) {
            
            
            block(info,nil);
        }else{
            block(info,nil);
        }
    }];
    
}
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
        if (info.status == kRetCodeSucess) {
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

@implementation ZLPlafarmtLogin
+ (void)WKRegistWechatOpenId:(NSDictionary *)para block:(void(^)(MWBaseObj *info))block{

    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/user.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info);
        }else{
            block(info);
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
+ (void)MWFindDeviceInfo:(NSDictionary *)para block:(void(^)(MWBaseObj *info,NSArray *mArr))block{
    [[WKHttpRequest initClient] WKMWPostDataWithUrl:@"wx/wash.php" withPara:para block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            block(info,nil);
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
@end

@implementation MWDeviceInfo
@end
@implementation MWSchoolInfo
@end


