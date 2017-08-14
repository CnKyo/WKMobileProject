//
//  WKTaskDetailViewController.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"
#import "RKImageBrowser.h"

@interface WKTaskDetailViewController : WKBaseViewController

/**
 1:任务详情。 2:活动详情
 */
@property (assign,nonatomic) WKTaskAndActivity mType;

@property (nonatomic,strong) RKImageBrowser  *mScrollerView;

@end
