//
//  WKPlayGameCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKPlayGameCell.h"

@implementation WKPlayGameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMGame:(MWGameObj *)mGame{
    [self.mImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mGame.game_logo]] placeholderImage:nil];
    self.mName.text = mGame.game_name;
    self.mPayPrice.text = [NSString stringWithFormat:@"消耗:%d金币",mGame.pay_coin_num];
}

@end
