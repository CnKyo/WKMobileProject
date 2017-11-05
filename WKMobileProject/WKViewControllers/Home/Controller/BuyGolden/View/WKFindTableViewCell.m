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

- (void)setMNews:(WKNews *)mNews{
    
//    @property (weak, nonatomic) IBOutlet UILabel *mName;
//    @property (weak, nonatomic) IBOutlet UILabel *mSource;
//    @property (weak, nonatomic) IBOutlet UIImageView *mImg;
    
    self.mName.text = mNews.title;
    self.mSource.text = mNews.date;
    [self.mImg sd_setImageWithURL:[NSURL URLWithString:mNews.thumbnail_pic_s] placeholderImage:nil];
    
}
@end
