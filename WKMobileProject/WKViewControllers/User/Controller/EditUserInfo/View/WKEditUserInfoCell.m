//
//  WKEditUserInfoCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKEditUserInfoCell.h"
@implementation WKEditUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{

    self.mLoginOutBtn.layer.cornerRadius = 3.0f;
}

- (IBAction)mBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(WKEditUserInfoCellDelegateWithBtnClicked:)]) {
        [self.delegate WKEditUserInfoCellDelegateWithBtnClicked:sender.tag];
    }
    
}


@end
