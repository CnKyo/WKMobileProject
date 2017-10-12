//
//  WKDriverCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKDriverCell.h"

@implementation WKDriverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.mConnectBtn.layer.masksToBounds = YES;
    self.mConnectBtn.layer.cornerRadius = 3;
    self.mConnectBtn.layer.borderColor = [UIColor colorWithRed:0.294 green:0.447 blue:0.961 alpha:1].CGColor;
    self.mConnectBtn.layer.borderWidth = 1;
    
}
@end
