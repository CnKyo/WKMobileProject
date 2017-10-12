//
//  WKRegistCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WKRegistCellDelegate <NSObject>

@optional

/**
 按钮代理方法
 
 @param mTag 0:验证码。1:注册。2:去登录
 */
- (void)WKRegistCellDelegateBtnActions:(NSInteger)mTag;
@end
@interface WKRegistCell : UITableViewCell
@property (weak,nonatomic) id<WKRegistCellDelegate>delegate;

@end
