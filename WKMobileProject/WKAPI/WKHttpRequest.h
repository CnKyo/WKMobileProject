//
//  WKHttpRequest.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/27.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKHeader.h"
#import "WKModel.h"
#import "AppDelegate.h"
@class MWBaseObj;
@class WKBaseInfo;
@class WKJUHEObj;
@class MWBaiDuApiBaseObj;
@interface WKHttpRequest : AFHTTPSessionManager

@property(nonatomic, strong) NSMutableDictionary *conDic;//存网络链接，便于取消
///本地api地址
+ (instancetype)initLocalApiclient;
- (void)MWPostWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(MWBaseObj *info))block;

///百度api的
+ (instancetype)initBaiDuAPI;
#pragma mark----****----*  封装的get请求
/**
 *  封装的get请求
 *
 *  @param url          url
 *  @param para          参数
 *  @param block 请求成功的回调
 */
- (void)WKBaiDuGetDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(MWBaiDuApiBaseObj *info))block;

///乐校园的
+ (instancetype)initClient;
///mob的
+ (instancetype)shareClient;
///聚合数据的
+ (instancetype)initJUHEApiClient;

/**
 *  封装的get请求
 *
 *  @param str          url
 *  @param dic          参数
 *  @param successBlock 请求成功的回调
 *  @param failueBlock  请求失败的回调
 */
+ (void)WKGetNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock;
/**
 *  封装的post请求
 *
 *  @param str          url
 *  @param dic          参数
 *  @param successBlock 请求成功的回调
 *  @param failueBlock  请求失败的回调
 */
+ (void)WKPostNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock;
#pragma mark----****----*  封装的post请求
/**
 *  封装的post请求
 *
 *  @param url          url
 *  @param para          参数
 *  @param block 请求成功的回调
 */
- (void)WKPostDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(WKBaseInfo *info))block;

#pragma mark----****----*  封装的get请求
/**
 *  封装的get请求
 *
 *  @param url          url
 *  @param para          参数
 *  @param block 请求成功的回调
 */
- (void)WKGetDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(WKBaseInfo *info))block;
- (void)WKJHGetDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(WKJUHEObj *info))block;
- (void)WKMWGetDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(MWBaseObj *info))block;

- (void)WKMWPostDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(MWBaseObj *info))block;

/**
 图片上传

 @param urlStr     url
 @param parameters 参数
 @param fileData   文件
 @param name       名称
 @param fileName   文件名称
 @param fileType   文件类型
 @param success    请求成功的回调
 @param fail       请求失败的回调
 */
+ (void)WKPostUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)())fail;

+ (void)WKPostUploadWithUrl:(NSString *)urlStr  uploadImages:(NSArray *)images completion:(void(^)(NSString *url,NSError *error))uploadBlock andPramaDic:(NSDictionary *)paramaDic;

+ (NSString*)nowTime:(NSString*)dateType;

@end
