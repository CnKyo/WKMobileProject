//
//  WKAPIManager.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "CTAPIBaseManager.h"
#import "CTNetworking.h"

extern NSString * const kTestAPIManagerParamsKeyLatitude;
extern NSString * const kTestAPIManagerParamsKeyLongitude;
@interface WKAPIManager : CTAPIBaseManager<CTAPIManager,CTAPIManagerValidator,CTAPIManagerParamSource, CTAPIManagerCallBackDelegate>

@property (assign,nonatomic)NSString *APIName;
    
@end
