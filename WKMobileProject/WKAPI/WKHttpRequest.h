//
//  WKHttpRequest.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/27.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKHeader.h"
#import "AppDelegate.h"
@interface WKHttpRequest : AFHTTPSessionManager

+ (instancetype)shareClient;

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
