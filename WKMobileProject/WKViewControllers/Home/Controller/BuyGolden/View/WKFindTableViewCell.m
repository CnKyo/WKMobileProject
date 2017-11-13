//
//  WKFindTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKFindTableViewCell.h"

@implementation WKFindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMNews:(MWDiscoveryObj *)mNews{
   
    self.mName.text = mNews.func_title;
    self.mSource.text = [Util WKTimeIntervalToDate:mNews.add_time];
    [self.mImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mNews.func_img]] placeholderImage:nil];
    
}
@end
