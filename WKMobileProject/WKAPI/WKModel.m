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
    
    [[WKHttpRequest shareClient] WKPostDataWithUrl:@"queryByTrainNo" withPara:param block:^(WKBaseInfo *info) {
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

@implementation WKModel

@end
@implementation WKTrainName

@end
