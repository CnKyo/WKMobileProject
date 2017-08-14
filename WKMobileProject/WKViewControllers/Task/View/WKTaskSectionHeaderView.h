//
//  WKTaskSectionHeaderView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKTaskSectionHeaderView : UIView

/**
 任务名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mTaskName;

/**
 剩余任务量
 */
@property (weak, nonatomic) IBOutlet UILabel *mResidue;

/**
 价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;

/**
 任务时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTaskTime;

/**
 说明
 */
@property (weak, nonatomic) IBOutlet UILabel *mExplain;

+ (WKTaskSectionHeaderView *)initView;

+ (WKTaskSectionHeaderView *)initActivityView;


@end
