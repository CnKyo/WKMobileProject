//
//  WKMyTaskDetailViewController.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WKMyTaskDetailViewController : WKBaseViewController

@property (assign,nonatomic) WKTaskStatus mStatus;
@property (strong,nonatomic) MWMyTaskOrderObj *mTask;
@property (assign,nonatomic) NSInteger mTaskType;

@end
