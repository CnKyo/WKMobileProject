//
//  ControlRunLoopTool.h
//  NSTimerDemo
//
//  Created by Gin on 16/11/1.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 控制使用 runLoop 与 timer 进行结合使用
@interface ControlRunLoopTool : NSObject

/// 是否使用 runLoop 与 timer 进行结合使用
@property (nonatomic, assign) BOOL useRunLoop;

/// 单例
+ (instancetype)sharedTool;

@end
