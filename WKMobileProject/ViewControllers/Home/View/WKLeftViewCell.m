//
//  WKLeftViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKLeftViewCell.h"

@implementation WKLeftViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(WKLeftViewCellDelegateWithBtnAction:)]) {
        [self.delegate WKLeftViewCellDelegateWithBtnAction:sender.tag];
    }
    
}

@end
