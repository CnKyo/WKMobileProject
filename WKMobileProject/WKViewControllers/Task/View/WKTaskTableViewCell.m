//
//  WKTaskTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTaskTableViewCell.h"

@implementation WKTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMTask:(MWTaskObj *)mTask{
    [self.mImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mTask.task_image]] placeholderImage:nil];
    self.mName.text = mTask.task_title;
    self.mTimes.text = [NSString stringWithFormat:@"剩余%@次",mTask.task_leave_num];
    self.mPrice.text = [NSString stringWithFormat:@"¥%@/次",mTask.task_price];
}
@end
