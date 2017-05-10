//
//  WKHomeDecomandedCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKHomeDecomandedCell.h"
#import "WKHeader.h"

@implementation WKHomeDecomandedCell

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.mLeftImg zy_cornerRadiusAdvance:5 rectCornerType:UIRectCornerAllCorners];
    [self.mrightImg zy_cornerRadiusAdvance:5 rectCornerType:UIRectCornerAllCorners];
    
    [self.mLeftImg sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg"] placeholderImage:nil];

    [self.mrightImg sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg"] placeholderImage:nil];

    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)mLeftAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKHomeDecomandedCellDelegateWithLeftBtnClicked:)]) {
        [self.delegate WKHomeDecomandedCellDelegateWithLeftBtnClicked:self.mIndex];
    }

}
- (IBAction)mRightAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WKHomeDecomandedCellDelegateWithRightBtnClicked:)]) {
        [self.delegate WKHomeDecomandedCellDelegateWithRightBtnClicked:self.mIndex];
    }
    
}

@end
