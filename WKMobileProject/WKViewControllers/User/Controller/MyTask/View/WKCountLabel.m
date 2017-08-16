//
//  WKCountLabel.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKCountLabel.h"

@implementation WKCountLabel
- (void)setupProperty{
    
    self.timeKey = @"endTime";
    //设置过时数据自动删除
    self.isAutomaticallyDeleted = YES;
}
@end
