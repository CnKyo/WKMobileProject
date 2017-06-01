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

@interface WKModel : NSObject

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
