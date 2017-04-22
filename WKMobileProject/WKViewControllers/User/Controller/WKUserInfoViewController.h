//
//  WKUserInfoViewController.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/18.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WKUserInfoViewController : WKBaseViewController
@property (nonatomic,weak) void(^block)(NSString *mBlock);
@property (strong,nonatomic)NSString *mText;
@end
