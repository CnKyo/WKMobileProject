//
//  WKMyTaskDetailHeadCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKMyTaskDetailHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mStatusImg;

@property (weak, nonatomic) IBOutlet UILabel *mStatusContent;

/**
 任务状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mTaskStatus;

/**
 任务名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mTaskName;

/**
 任务剩余量
 */
@property (weak, nonatomic) IBOutlet UILabel *mTaskResidueNum;

/**
 任务酬劳
 */
@property (weak, nonatomic) IBOutlet UILabel *mTaskPrice;

/**
 任务截止时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTaskEndTime;

/**
 任务说明
 */
@property (weak, nonatomic) IBOutlet UILabel *mTaskExplain;

/**
 任务状态高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mStatusH;


@end
