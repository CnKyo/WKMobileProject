//
//  WKUserInfoAdCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserInfoAdCell.h"

@implementation WKUserInfoAdCell

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
    self.mLeftImg.layer.cornerRadius = self.mRightImg.layer.cornerRadius = 4;
}
- (IBAction)mLeftAction:(id)sender {
    if ([self.delegete respondsToSelector:@selector(WKUserInfoAdCellDelegateWithLeftBtn:)]) {
        [self.delegete WKUserInfoAdCellDelegateWithLeftBtn:self.mIndexPath];
    }
    
}
- (IBAction)mRightAction:(id)sender {
    if ([self.delegete respondsToSelector:@selector(WKUserInfoAdCellDelegateWithRightBtn:)]) {
        [self.delegete WKUserInfoAdCellDelegateWithRightBtn:self.mIndexPath];
    }
    
}

@end
