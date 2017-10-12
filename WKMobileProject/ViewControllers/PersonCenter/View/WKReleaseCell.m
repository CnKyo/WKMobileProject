//
//  WKReleaseCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKReleaseCell.h"

@implementation WKReleaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKReleaseCellDelegateWithBtnAction:)]) {
        [self.delegate WKReleaseCellDelegateWithBtnAction:sender.tag];
        
    }
}

@end
