//
//  WKWashBookingCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashBookingCell.h"
#import "WKHeader.h"
@implementation WKWashBookingCell

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
    
    self.mBtn.layer.cornerRadius = 3;
}
- (IBAction)mBtnAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKWashBookingCellBtnAction:)]) {
        [self.delegate WKWashBookingCellBtnAction:self.mIndexPath];
    }
    
}


@end
