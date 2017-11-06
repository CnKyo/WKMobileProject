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

