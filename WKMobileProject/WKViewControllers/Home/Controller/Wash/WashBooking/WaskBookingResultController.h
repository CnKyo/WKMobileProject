//
//  WaskBookingResultController.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WaskBookingResultController : WKBaseViewController

@property(strong,nonatomic) MWDeviceInfo *mDeviceInfo;
@property(strong,nonatomic) NSString *mCode;
///扫描类型。 1:直接扫描过来。  2:预约洗衣机。
@property(assign,nonatomic) NSInteger mType;
@end
