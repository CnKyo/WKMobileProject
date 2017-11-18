//
//  WKMyTaskViewController.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"
#import "ZJJTimeCountDown.h"

@interface WKMyTaskViewController : WKBaseViewController<ZJJTimeCountDownDelegate>
@property(nonatomic,strong) ZJJTimeCountDown *countDown;

@end
