//
//  WKScanDeviceViewController.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/1.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WKScanDeviceViewController : WKBaseViewController

/**
 扫描类型 1：扫描设备二维码，2：验证机器
 */
@property (assign,nonatomic) MWScanType mTyp;

@end
