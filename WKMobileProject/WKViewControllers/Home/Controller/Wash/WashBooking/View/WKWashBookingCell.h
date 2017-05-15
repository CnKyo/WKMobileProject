//
//  WKWashBookingCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理
@protocol WKWashBookingCellDelegate <NSObject>

@optional
///预约按钮代理方法
- (void)WKWashBookingCellBtnAction:(NSIndexPath *)mIndexPath;

@end

@interface WKWashBookingCell : UITableViewCell
///背景图
@property (weak, nonatomic) IBOutlet UIImageView *mBgkImg;
///状态
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
///内容
@property (weak, nonatomic) IBOutlet UILabel *mContent;
///按钮
@property (weak, nonatomic) IBOutlet UIButton *mBtn;
///索引
@property (weak,nonatomic) NSIndexPath *mIndexPath;
///设置代理
@property (weak,nonatomic) id<WKWashBookingCellDelegate>delegate;


@end
