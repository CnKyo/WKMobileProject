//
//  MyTaskTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "MyTaskTableViewCell.h"

@implementation MyTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)mBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MyTaskTableViewCellDelegateWithBtnAction:)]) {
        [self.delegate MyTaskTableViewCellDelegateWithBtnAction:self.mIndexPath];
    }
    
}

@end
