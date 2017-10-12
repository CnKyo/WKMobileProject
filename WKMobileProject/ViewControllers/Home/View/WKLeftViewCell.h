//
//  WKLeftViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WKLeftViewCellDelegate <NSObject>

@optional

/**
 按钮代理方法

 @param mTag 0:个人信息 1:我的余额 2:接单数 3:车辆 4:订单 5:消息  6:设置。7:退出
 */
- (void)WKLeftViewCellDelegateWithBtnAction:(NSInteger)mTag;

@end
@interface WKLeftViewCell : UITableViewCell

@property (weak,nonatomic) id<WKLeftViewCellDelegate>delegate;
@end
