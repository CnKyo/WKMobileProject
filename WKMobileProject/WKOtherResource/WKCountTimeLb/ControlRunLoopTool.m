//
//  ControlRunLoopTool.m
//  NSTimerDemo
//
//  Created by Gin on 16/11/1.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import "ControlRunLoopTool.h"

@implementation ControlRunLoopTool

static ControlRunLoopTool *_instance;

+ (instancetype)sharedTool {
    
    if (_instance == nil) {
        _instance = [[ControlRunLoopTool alloc] init];
        _instance.useRunLoop = YES;
    }
    return _instance;
}

@end
