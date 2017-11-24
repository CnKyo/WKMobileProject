//
//  WKMyGoldenCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyGoldenCell.h"

@implementation WKMyGoldenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMGold:(MWGoldListObj *)mGold{
    
    if ([mGold.income_expenditure isEqualToString:@"1"]) {
        self.mNum.text = [NSString stringWithFormat:@"+%@",mGold.money];

    }else{
        self.mNum.text = [NSString stringWithFormat:@"-%@",mGold.money];

    }
    
    self.mName.text = mGold.title;
    self.mTime.text = mGold.content;
}
@end
