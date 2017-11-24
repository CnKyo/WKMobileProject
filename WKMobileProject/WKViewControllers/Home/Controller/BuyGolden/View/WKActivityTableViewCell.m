//
//  WKActivityTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKActivityTableViewCell.h"

@implementation WKActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMActObj:(WKHome *)mActObj{
    [self.mImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mActObj.banner_img]] placeholderImage:WKDefaultBannerImg];
    self.mName.text = mActObj.banner_title;
}

@end
