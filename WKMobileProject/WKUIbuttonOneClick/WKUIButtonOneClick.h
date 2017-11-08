//
//  WKUIButtonOneClick.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TouchOne)

/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;

/**
 *  bool YES 忽略点击事件   NO 允许点击事件
 */
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end
