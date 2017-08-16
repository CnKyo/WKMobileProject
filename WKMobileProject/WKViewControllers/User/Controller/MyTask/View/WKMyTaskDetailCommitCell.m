//
//  WKMyTaskDetailCommitCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyTaskDetailCommitCell.h"

@implementation WKMyTaskDetailCommitCell

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
    
    self.mWriteDataView.layer.masksToBounds = YES;
    self.mWriteDataView.layer.cornerRadius = 4;
    self.mWriteDataView.layer.borderWidth = 1;
    self.mWriteDataView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKMyTaskDetailCommitCellWithBtnClicked:)]) {
        [self.delegate WKMyTaskDetailCommitCellWithBtnClicked:sender.tag];
    }
    
}


@end
