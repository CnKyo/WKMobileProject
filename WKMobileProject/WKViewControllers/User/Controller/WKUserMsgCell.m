//
//  WKUserMsgCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserMsgCell.h"

@implementation WKUserMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMMSG:(MWMessageObj *)mMSG{
    self.mName.text = mMSG.title;
//    self.mTime.text = [Util DateTimeInt:mMSG.add_time];
    self.mTime.text = mMSG.content;
}
@end
