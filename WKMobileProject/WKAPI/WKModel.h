//
//  WKModel.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/24.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKModel : NSObject

@end

@interface WKJPushAPSObj : NSObject
@property (nonatomic, strong) NSString *            alert;              //
@property (nonatomic, assign) int                   badge;              //
@property (nonatomic, strong) NSString *            sound;              //
@end

@interface WKJPushObj : NSObject

@property (nonatomic, strong) NSString *            _j_msgid;              //
@property (nonatomic, strong) WKJPushAPSObj *aps;              //
@property (nonatomic, strong) NSString *            model;              //
@property (nonatomic, assign) int                   msg_type;              //
@property (nonatomic, assign) int                   odr_id;              //
@property (nonatomic, strong) NSString *            odr_type;              //
@property (nonatomic, assign) int                   odr_code;              //
@property (nonatomic, strong) NSString *            url;              //

@end
