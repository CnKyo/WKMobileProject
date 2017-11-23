//
//  WKHttpRequest.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/27.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKHttpRequest.h"
#import "NSNetworkManager.h"
#import "AppDelegate.h"
@implementation WKHttpRequest
///本地api地址
+ (instancetype)initLocalApiclient{
    static WKHttpRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WKHttpRequest alloc] initWithBaseURL:[NSURL URLWithString:kLocalAPIUrlString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        ;
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
    });
    return _sharedClient;
}
- (void)MWPostWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(MWBaseObj *info))block{
    [[NSNetworkRequest sharedInstance] MWPOSTWithUrl:url parameters:para cacheMode:NO successBlock:^(id responseObject) {
        MLLog(@"responseObject----:%@",responseObject);
        
        MWBaseObj *info = [MWBaseObj yy_modelWithJSON:responseObject];
        block(info);
    } failureBlock:^(NSError *error) {
        
        MLLog(@"错了：%@",error.description);
        MWBaseObj *info = [MWBaseObj infoWithError:error];
        info.err_code = 1;
        
        block(info);
    }];
    
}

///百度api的
+ (instancetype)initBaiDuAPI{
    static WKHttpRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[WKHttpRequest alloc] initWithBaseURL:[NSURL URLWithString:kBaiDuAPIURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        ;
        //_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        //_sharedClient.requestSerializer.Content = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _sharedClient;
}
/**
 *  封装的get请求
 *
 *  @param url          url
 *  @param para          参数
 *  @param block 请求成功的回调
 */
- (void)WKBaiDuGetDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(MWBaiDuApiBaseObj *info))block{
    [[NSNetworkRequest sharedInstance] BaiDuGET:url parameters:para cacheMode:NO successBlock:^(id responseObject) {
        MLLog(@"%@\n缓存路径为:  %@",responseObject,kPathCache);
        //        MLLog(@"responseObject----:%@",responseObject);
        
        
        MWBaiDuApiBaseObj *info = [MWBaiDuApiBaseObj yy_modelWithJSON:responseObject];
        
        block(info);
        
        //        [TSMessage showNotificationWithTitle:@"GET请求成功,已缓存!" type:TSMessageNotificationTypeWarning];
    } failureBlock:^(NSError *error) {
        MLLog(@"%@",error);
        //        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"GET请求失败:%@",error.description] type:TSMessageNotificationTypeWarning];
        
        block(nil);
        
    }];
}
+ (instancetype)initClient{
    static WKHttpRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[WKHttpRequest alloc] initWithBaseURL:[NSURL URLWithString:kLeSchoolAPIURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        ;
        //_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        //_sharedClient.requestSerializer.Content = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _sharedClient;
}
+ (instancetype)shareClient{
    static WKHttpRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[WKHttpRequest alloc] initWithBaseURL:[NSURL URLWithString:kMobWeatherAPIURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        ;
        //_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        //_sharedClient.requestSerializer.Content = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _sharedClient;
}
+ (instancetype)initJUHEApiClient{
    static WKHttpRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[WKHttpRequest alloc] initWithBaseURL:[NSURL URLWithString:kJUHEAPIAddressUrlString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        ;
        //_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        //_sharedClient.requestSerializer.Content = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _sharedClient;
}

+ (void)WKGetNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock{
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *netManager = [AFHTTPSessionManager manager];
    netManager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    netManager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    netManager.requestSerializer.timeoutInterval=15.0;
    
    
    [netManager GET:str parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (successBlock) {
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failueBlock) {
            failueBlock();
        }
    }];

}
/**
 *  封装的post请求
 *
 *  @param str          url
 *  @param dic          参数
 *  @param successBlock 请求成功的回调
 *  @param failueBlock  请求失败的回调
 */
+ (void)WKPostNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock{
    AFHTTPSessionManager *netManager   = [AFHTTPSessionManager manager];
    netManager.requestSerializer      = [AFHTTPRequestSerializer serializer];
    netManager.responseSerializer     = [AFHTTPResponseSerializer serializer];
    netManager.requestSerializer.timeoutInterval=15.0;
    
    [netManager POST:str parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (successBlock) {
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failueBlock) {
            failueBlock();
        }
    }];
}
#pragma mark----****----*  封装的get请求
/**
 *  封装的get请求
 *
 *  @param url          url
 *  @param para          参数
 *  @param block 请求成功的回调
 */
- (void)WKGetDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(WKBaseInfo *info))block{
    [[NSNetworkRequest sharedInstance] GET:url parameters:para cacheMode:NO successBlock:^(id responseObject) {
        MLLog(@"%@\n缓存路径为:  %@",responseObject,kPathCache);
        //        MLLog(@"responseObject----:%@",responseObject);
        
        
        WKJUHEObj *info = [WKJUHEObj yy_modelWithJSON:responseObject];
        
        block(info);
        
        //        [TSMessage showNotificationWithTitle:@"GET请求成功,已缓存!" type:TSMessageNotificationTypeWarning];
    } failureBlock:^(NSError *error) {
        MLLog(@"%@",error);
        //        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"GET请求失败:%@",error.description] type:TSMessageNotificationTypeWarning];
        
        block(nil);
        
    }];
}
#pragma mark----****----*  封装的post请求
/**
 *  封装的post请求
 *
 *  @param url          url
 *  @param para          参数
 *  @param block 请求成功的回调
 */
- (void)WKPostDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(WKBaseInfo *info))block{

//    [self urlGroupKey:nil path:url parameters:para call:^(NSError *error, id responseObject) {
//        if (error == nil) {
//            MLLog(@"responseObject----:%@",responseObject);
//            
//            WKBaseInfo *info = [WKBaseInfo yy_modelWithJSON:responseObject];
//            block(info);
//        }else{
//            WKBaseInfo *info = [WKBaseInfo infoWithError:error];
//            info.status = kRetCodeError;
//
//            block(info);
//        }
//    }];
    
    [[NSNetworkRequest sharedInstance] POST:url parameters:para cacheMode:YES successBlock:^(id responseObject) {
        MLLog(@"responseObject----:%@",responseObject);
        
        WKBaseInfo *info = [WKBaseInfo yy_modelWithJSON:responseObject];
        block(info);
    } failureBlock:^(NSError *error) {
        WKBaseInfo *info = [WKBaseInfo infoWithError:error];
        info.status = kRetCodeError;
        
        block(info);
    }];

}


#pragma mark----****----*  封装的get请求
/**
 *  封装的get请求
 *
 *  @param url          url
 *  @param para          参数
 *  @param block 请求成功的回调
 */
- (void)WKMWGetDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(MWBaseObj *info))block{


    [[NSNetworkRequest sharedInstance] MWGET:url parameters:para cacheMode:NO successBlock:^(id responseObject) {
        MLLog(@"%@\n缓存路径为:  %@",responseObject,kPathCache);
//        MLLog(@"responseObject----:%@",responseObject);
        
        
        MWBaseObj *info = [MWBaseObj yy_modelWithJSON:responseObject];
        block(info);

//        [TSMessage showNotificationWithTitle:@"GET请求成功,已缓存!" type:TSMessageNotificationTypeWarning];
    } failureBlock:^(NSError *error) {
        MLLog(@"%@",error);
//        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"GET请求失败:%@",error.description] type:TSMessageNotificationTypeWarning];
        MWBaseObj *info = [MWBaseObj infoWithError:error];
        info.err_code = kRetCodeError;
        
        block(info);

    }];

}
#pragma mark----****----洗衣机总接口
- (void)WKMWPostDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(MWBaseObj *info))block{
    [[NSNetworkRequest sharedInstance] MWFormPOST:url parameters:para cacheMode:NO successBlock:^(id responseObject) {
        MLLog(@"responseObject----:%@",responseObject);
        
        MWBaseObj *info = [MWBaseObj yy_modelWithJSON:responseObject];
///如果需要登录就在这里判断
        //        if (info.err_code == 1) {
//            [((AppDelegate*)[UIApplication sharedApplication].delegate) performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
//            block(nil);
//        }else{
            block(info);
//        }
        
    } failureBlock:^(NSError *error) {
        MWBaseObj *info = [MWBaseObj infoWithError:error];
        info.err_code = kRetCodeError;
        
        block(info);
    }];
}

- (void)WKJHGetDataWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(WKJUHEObj *info))block{
    [[NSNetworkRequest sharedInstance] JHGET:url parameters:para cacheMode:NO successBlock:^(id responseObject) {
        MLLog(@"%@\n缓存路径为:  %@",responseObject,kPathCache);
        //        MLLog(@"responseObject----:%@",responseObject);
        
        
        WKJUHEObj *info = [WKJUHEObj yy_modelWithJSON:responseObject];
        
        block(info);
        
        //        [TSMessage showNotificationWithTitle:@"GET请求成功,已缓存!" type:TSMessageNotificationTypeWarning];
    } failureBlock:^(NSError *error) {
        MLLog(@"%@",error);
        //        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"GET请求失败:%@",error.description] type:TSMessageNotificationTypeWarning];
        
        block(nil);
        
    }];
}

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
+ (void)WKPostUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)())fail{
    AFJSONResponseSerializer *serializer  = [AFJSONResponseSerializer serializer];
    AFHTTPSessionManager *manager       = [AFHTTPSessionManager manager];
    manager.responseSerializer         = serializer;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 15;
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:fileType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail();
        }
    }];

}
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
- (void)MWPostFileWithUrl:(NSString *)urlStr andPara:(NSDictionary *)para fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)())fail{
    AFJSONResponseSerializer *serializer  = [AFJSONResponseSerializer serializer];
    AFHTTPSessionManager *manager       = [AFHTTPSessionManager manager];
    manager.responseSerializer         = serializer;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 15;
    [manager POST:urlStr parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:fileType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail();
        }
    }];
}
-(void)urlGroupKey:(NSString *)key path:(NSString *)URLString parameters:(id)parameters call:(void (^)(NSError *error, id responseObject))callback
{
    MLLog(@" 参数是：  %@  \n url链接是：  %@",parameters,URLString);
    id operation = nil;
    operation = [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(nil, responseObject);
        [self removeConnection:operation group:key];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(error, nil);
        [self removeConnection:operation group:key];
    }];
    [self addConnection:operation group:key];
}
- (void)removeConnection:(NSURLSessionDataTask *)operation group:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if ([arr containsObject:operation]) {
        [arr removeObject:operation];
        [self.conDic setObject:arr forKey:key];
    }
}
- (void)addConnection:(NSURLSessionDataTask *)operation group:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if (arr == nil)
        arr = [[NSMutableArray alloc] init];
    [arr addObject:operation];
    
    if (key==nil || key.length==0)
        key = @"defaultKey";
    
    [self.conDic setObject:arr forKey:key];
}
#pragma mark----****----阿凡达数据请求
///阿凡达数据请求
+ (instancetype)initAFanDaApiClient{
    static WKHttpRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[WKHttpRequest alloc] initWithBaseURL:[NSURL URLWithString:kAFanDaURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        ;
        //_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        //_sharedClient.requestSerializer.Content = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _sharedClient;
}
#pragma mark----****----阿凡达数据请求
/**
 阿凡达数据请求
 
 @param url url
 @param para 参数
 @param block 返回值
 */
- (void)MWAFanDaPostWithUrl:(NSString*)url withPara:(NSDictionary*)para block:(void(^)(WKJUHEObj *info))block{
    [[NSNetworkRequest sharedInstance] MWAFanDaPOSTWithUrl:url parameters:para cacheMode:NO successBlock:^(id responseObject) {
        MLLog(@"responseObject----:%@",responseObject);
        
        WKJUHEObj *info = [WKJUHEObj yy_modelWithJSON:responseObject];
        block(info);
    } failureBlock:^(NSError *error) {
        
        MLLog(@"错了：%@",error.description);
        WKJUHEObj *info = [WKJUHEObj infoWithError:error];
        info.error_code = 1;
        
        block(info);
    }];
}


#pragma mark----****----图片上传
/**
 图片上传
 
 @param tag <#tag description#>
 @param uploadDatas <#uploadDatas description#>
 @param type <#type description#>
 @param path <#path description#>
 @param callback <#callback description#>
 */
-(void)fileUploadWithTag:(NSObject *)tag uploadDatas:(NSArray *)uploadDatas type:(NSInteger)type path:(NSString *)path call:(TableArrBlock)callback{
    WKUser *user = [WKUser currentUser];
    if (user.member_id.length == 0) {
        
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setObject:[NSString stringWithFormat:@"%ld",type] forKey:@"type"];
        [paramDic setObject:path forKey:@"path"];
        [paramDic setObject:user.member_id forKey:@"user_id"];
        
        [self postWithTag:tag path:@"upLoadImg.php" parameters:paramDic constructingBodyWithBlockBack:^(id<AFMultipartFormData> formData) {
            NSString *mimeType = nil;
            NSString *fileExt = nil;
            
            switch (type) {
                case kFileType_photo:
                    fileExt = @".png";
                    mimeType = @"image/jpg/png";
                    break;
                case kFileType_video:
                    fileExt = @".mp4";
                    mimeType = @"video/mpeg4";
                    break;
                default:
                    break;
            }
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *timeStr = [formatter stringFromDate:[NSDate date]];
            
            for (int i=0; i<uploadDatas.count; i++) {
                NSString *fileName = [NSString stringWithFormat:@"%@_%i%@",timeStr, i, fileExt];
                NSString *name = [NSString stringWithFormat:@"uploadFile%i", i];
                [formData appendPartWithFileData:uploadDatas[i] name:name fileName:fileName mimeType:mimeType];
            }
            
        } call:^(NSError *error, id responseObject) {
            MWBaseObj *info = nil;
            if (error == nil) {
                NSLog(@"\n\n ---APIObject----result:-----------%@", responseObject);
                info = [MWBaseObj yy_modelWithDictionary:responseObject];
                if (info==nil)
                    info = [MWBaseObj infoWithErrorMessage:@"网络错误"];
            } else {
                NSLog(@"\n\n ---APIObject----result error:-----------%@", error);
                info = [MWBaseObj infoWithError:error];
            }
            
            if (info.err_code == 0) {
//                NSString *newArr = [FileUploadResponseObject yy_modelWithDictionary:info.data];
                callback(nil, info);
            } else
                callback(nil, info);
            
        }];
    } else
        callback(nil, [MWBaseObj infoWithErrorMessage:@"请重新登陆"]);
}
/**
 *  上传图片方法
 *
 *  @param tag        tag
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param block      返回值
 *  @param callback   返回值
 */
-(void)postWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlockBack:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(NSError *error, id responseObject))callback{
    NSString *key = NSStringFromClass([tag class]);
    id operation = nil;
    operation = [self POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(nil, responseObject);
        [self removeConnection:operation group:key];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(error, nil);
        [self removeConnection:operation group:key];
    }];
    [self addConnection:operation group:key];
}

#pragma mark----****----重写baseUrl方法
- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer.HTTPShouldHandleCookies = YES;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

        self.conDic = [NSMutableDictionary dictionary];
    }
    return self;
}
#pragma mark -
- (void)cancelHttpOpretion:(NSURLSessionDataTask *)http
{
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[NSURLSessionDataTask class]]) {
            continue;
        }
        if ([operation isEqual:http]) {
            [operation cancel];
            break;
        }
    }
}
- (void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( MWBaseObj* info))callback{
    
    MLLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = 10;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager GET:[NSString stringWithFormat:@"%@/%@",kLocalAPIUrlString,URLString] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MLLog(@"data:%@",responseObject);
        
        NSDictionary *resbObj = [Util deleteEmpty:responseObject];
        
        MLLog(@"去掉字典里的null值之后的数据：%@",resbObj);
        
        MWBaseObj   *retob = [MWBaseObj yy_modelWithDictionary:resbObj];
        
        callback(  retob );
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MLLog(@"error:%@",error.description);
        callback( [MWBaseObj infoWithError:error] );
        
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
}
#pragma mark----****----重写请求方法
/**
 重写请求方法
 
 @param tag tag
 @param URLString 请求地址
 @param parameters 参数
 @param callback 返回值
 */
-(void)loadAPIWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters call:(void (^)(MWBaseObj* info))callback
{

    NSLog(@"URLString:%@ 参数parameters:%@", URLString, parameters);
    
    [self urlGroupKey:NSStringFromClass([tag class]) path:URLString parameters:parameters call:^(NSError *error, id responseObject) {
        MWBaseObj *info = nil;
        if (error == nil) {
            NSLog(@"\n\n ---APIObject----result:-----------%@", responseObject);
            info = [MWBaseObj yy_modelWithDictionary:responseObject];
            
            ///如果需要登录就在这里判断
            //        if (info.err_code == 1) {
            //            [((AppDelegate*)[UIApplication sharedApplication].delegate) performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
            //            block(nil);
            //        }else{
//            block(info);
            //        }
            if (info==nil)
                info = [MWBaseObj infoWithErrorMessage:@"网络错误"];
        } else {
            NSLog(@"\n\n ---APIObject----result error:-----------%@", error);
            info = [MWBaseObj infoWithError:error];
        }
        
        callback(info);
    }];
}
@end
