//
//  WKTaskDetailCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTaskDetailCell.h"

@implementation WKTaskDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMTask:(MWTaskObj *)mTask{
    self.mTitle.text = mTask.task_title;
    self.mContent.text = mTask.task_step;
}

@end
