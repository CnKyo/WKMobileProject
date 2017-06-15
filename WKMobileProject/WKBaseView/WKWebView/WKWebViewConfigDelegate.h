//
//  WKWebViewConfig.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
@interface WKWebViewConfigDelegate : NSObject<WKScriptMessageHandler>
@property (nonatomic,weak)id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
