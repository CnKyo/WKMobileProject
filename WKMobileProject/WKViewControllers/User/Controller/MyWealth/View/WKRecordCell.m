//
//  WKRecordCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKRecordCell.h"

@implementation WKRecordCell

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
    
    self.mCornerView.layer.masksToBounds = YES;
    self.mCornerView.layer.cornerRadius = 4;
    self.mCornerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mCornerView.layer.borderWidth = 1;
    
    self.mCommitBtn.layer.cornerRadius = 4;
    
}
@end
