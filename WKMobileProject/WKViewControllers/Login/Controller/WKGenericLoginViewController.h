//
//  WKGenericLoginViewController.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WKGenericLoginViewController : WKBaseViewController
///标题
@property (nonatomic,strong) NSString *mTitle;
///登录类型
@property (nonatomic,assign) WKLoginType mLoginType;
@end
