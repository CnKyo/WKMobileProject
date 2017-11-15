//
//  WKMyWealthTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyWealthTableViewCell.h"

@implementation WKMyWealthTableViewCell

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
    self.mBgkView.backgroundColor = M_CO;
    self.mDrawBtn.layer.cornerRadius = 3;
    
    [self.mexplain setImage:[UIImage imageNamed:@"icon_mywealth_explain"] forState:UIControlStateNormal];
    [self.mexplain setTitle:@"财富说明" forState:UIControlStateNormal];
    self.mexplain.titleLabel.font = [UIFont systemFontOfSize:13];
    self.mexplain.imageRect = CGRectMake(75, 10, 20, 20);
    self.mexplain.titleRect = CGRectMake(15, 10, 120, 20);
    
}

- (IBAction)mBtnAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(WKMyWealthTableViewCellBtnClickedWithTag:)]) {
        [_delegate WKMyWealthTableViewCellBtnClickedWithTag:sender.tag];
        
    }
}

- (void)setMMyRewards:(MWMyRewardsObj *)mMyRewards{
    NSDictionary* style1 = @{@"sfont": [UIFont systemFontOfSize:12],@"bfont": [UIFont systemFontOfSize:30]};
    self.mTotleWealth.attributedText = [[NSString stringWithFormat:@"<sfont>¥</sfont><bfont>%@</bfont>",mMyRewards.total_riches] attributedStringWithStyleBook:style1];
    self.mWealthAlreadyToMoney.text = [NSString stringWithFormat:@"¥%@",mMyRewards.arrived_cash];
    self.mWealthIng.text = [NSString stringWithFormat:@"¥%@",mMyRewards.arriving_cash];
    self.mWithDrawAlreadyToMoney.text = [NSString stringWithFormat:@"¥%@",mMyRewards.arrived_riches];
    self.mWithDrawIng.text = [NSString stringWithFormat:@"¥%@",mMyRewards.arriving_riches];

}
@end
