//
//  WKTaskTableViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
@interface WKTaskTableViewCell : UITableViewCell

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;

/**
 次数
 */
@property (weak, nonatomic) IBOutlet UILabel *mTimes;

@property (strong,nonatomic) MWTaskObj *mTask;

@end
