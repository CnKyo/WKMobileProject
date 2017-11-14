//
//  WKMyWashCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyWashCell.h"

@implementation WKMyWashCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)mBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(UITableViewCellDidSelectedIndexPath:)]) {
        [self.delegate UITableViewCellDidSelectedIndexPath:self.mIndexPath];
    }

}

- (void)setMWashObj:(MWWashOrderObj *)mWashObj{
    NSString *mS = @"";
    if ([mWashObj.order_type isEqualToString:@"2"]) {
        mS = @"进行中";
        self.mStatus.textColor = [UIColor lightTextColor];
    }else if([mWashObj.order_type isEqualToString:@"3"]){
        mS = @"超时返还";
        self.mStatus.textColor = [UIColor colorWithRed:0.29 green:0.6 blue:0.94 alpha:1];
    }else{
        mS = @"已完成";
        self.mStatus.textColor = [UIColor lightTextColor];
    }
    self.mStatus.text = mS;
    NSDictionary* style1 = @{@"color": [UIColor colorWithRed:0.97 green:0.58 blue:0.27 alpha:1]};
    self.mName.attributedText = [[NSString stringWithFormat:@"%@ <color> %@分钟  %@元</color>",mWashObj.location_name,mWashObj.wash_time,mWashObj.order_price] attributedStringWithStyleBook:style1];
}

@end
