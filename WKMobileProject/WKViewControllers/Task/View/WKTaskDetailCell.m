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

- (void)setMTask:(MWTaskContent *)mTask{
    self.mTitle.text = mTask.mTitle;
    self.mContent.text = mTask.mContent;
}
- (void)setMActivity:(WKHome *)mActivity{
    self.mTitle.text = mActivity.banner_title;
    self.mContent.text = mActivity.banner_content;
}
@end
