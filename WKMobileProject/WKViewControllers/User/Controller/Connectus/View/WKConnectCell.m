//
//  WKConnectCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/18.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKConnectCell.h"

@implementation WKConnectCell

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
    
    self.mImg.backgroundColor = [UIColor redColor];
    self.mConnectBtn.layer.cornerRadius = 3.0f;
}
@end
