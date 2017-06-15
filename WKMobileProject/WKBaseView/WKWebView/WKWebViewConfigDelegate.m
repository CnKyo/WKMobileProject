//
//  WKWebViewConfig.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWebViewConfigDelegate.h"

@implementation WKWebViewConfigDelegate
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
