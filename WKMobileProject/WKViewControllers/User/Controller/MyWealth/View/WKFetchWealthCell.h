//
//  WKFetchWealthCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKFetchWealthCell : UITableViewCell
///任务图片
@property (weak, nonatomic) IBOutlet UIImageView *mTaskImg;
///任务名称
@property (weak, nonatomic) IBOutlet UILabel *mTaskName;
///剩余次数
@property (weak, nonatomic) IBOutlet UILabel *mCountNum;
///多少天/次
@property (weak, nonatomic) IBOutlet UILabel *mDayTimes;
///多少钱/次
@property (weak, nonatomic) IBOutlet UILabel *mMoneyTimes;
///多少小时
@property (weak, nonatomic) IBOutlet UILabel *mTime;

@end
