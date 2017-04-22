//
//  WKTrainDemandCell.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/22.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTrainDemandCell.h"
#import "WKHeader.h"
@implementation WKTrainDemandCell

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
//    UIView *mSubLine = [UIView new];
//    mSubLine.backgroundColor = M_TextColor1;
//    
//    [self.mLine addSubview:mSubLine];
//    [mSubLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.mLine).offset(0);
//        make.height.offset(0.5);
//    }];
}

@end
