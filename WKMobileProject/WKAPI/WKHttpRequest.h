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

typedef void (^TableArrBlock)(NSString *tableArr, MWBaseObj* info);

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
#pragma mark----****----MW文件上传接口
/**
 文件上传接口

 @param urlStr url
 @param para 参数
 @param fileData 文件
 @param name 名称
 @param fileName 文件名称
 @param fileType 文件类型
 @param success 请求成功的回调
 @param fail 请求失败的回调
 */
- (void)MWPostFileWithUrl:(NSString *)urlStr andPara:(NSDictionary *)para fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)())fail;

+ (NSString*)nowTime:(NSString*)dateType;

#pragma mark----****----阿凡达数据请求
///阿凡达数据请求
+ (instancetype)initAFanDaApiClient;
#pragma mark----****----阿凡达数据请求
/**
 阿凡达数据请求

 @param url url
 @param para 参数
 @param block 返回值
 */
- (void)MWAFanDaPostWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(WKJUHEObj *info))block;


#pragma mark----****----图片上传
/**
 图片上传

 @param tag tag
 @param uploadDatas 图片文件
 @param type 图片类型
 @param path 文件路径
 @param callback 返回值
 */
-(void)fileUploadWithTag:(NSObject *)tag uploadDatas:(NSArray *)uploadDatas type:(NSInteger)type path:(NSString *)path call:(TableArrBlock)callback;
/**
 *  上传图片方法
 *
 *  @param tag        tag
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param block      返回值
 *  @param callback   返回值
 */
-(void)postWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlockBack:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(NSError *error, id responseObject))callback;
@end
