//
//  WKUserInfoCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserInfoCell.h"
#import "WKHeader.h"
@implementation WKUserInfoCell

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
    self.contentView.backgroundColor = M_BCO;
    [self.mSignBtn setButtonRoundedCornersWithView:self.contentView andCorners:UIRectCornerAllCorners radius:3.0];
}
- (IBAction)mHeadBtnAction:(UIButton *)sender {
    if ([self.delegete respondsToSelector:@selector(WKUserInfoCellDelegateWithBtnClicked:)]) {
        [self.delegete WKUserInfoCellDelegateWithBtnClicked:sender.tag];
    }
    
}



@end
