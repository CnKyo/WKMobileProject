//
//  WKGoPayCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKGoPayCell.h"

@implementation WKGoPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(WKGoPayCellDelegateWithBtnAction:)]) {
        [self.delegate WKGoPayCellDelegateWithBtnAction:sender.tag];
    }

    
}

@end
