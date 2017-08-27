//
//  WKHomeTableViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/27.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
@interface WKHomeTableViewCell : UITableViewCell

/**
 姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;

@property (strong,nonatomic) WKHomeModel *mHome;

@end
