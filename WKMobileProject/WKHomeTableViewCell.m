//
//  WKHomeTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/27.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKHomeTableViewCell.h"

@implementation WKHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMHome:(WKHomeModel *)mHome{
    self.mName.text = mHome.mName;
    self.mTime.text = mHome.mTime;
    self.mPrice.text = [NSString stringWithFormat:@"+%@",mHome.mPrice];
}

@end
