//
//  WKMyWealthRecordCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyWealthRecordCell.h"

@implementation WKMyWealthRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMRiches:(MWRichesHistoryObj *)mRiches{
    self.mName.text = mRiches.riches_title;
    NSString *mJ = mRiches.income_expenditure;
    if ([mJ isEqualToString:@"-1"]){
        mJ = @"-";
        
    }else{
        mJ = @"+";
        
    }
    self.mMoney.text = [NSString stringWithFormat:@"%@ %@",mJ,mRiches.money];
    NSString *mS = mRiches.riches_arrive_status;
    if ([mS isEqualToString:@"1"]) {
        mS = @"处理中";
    }else if ([mS isEqualToString:@"1"]){
        mS = @"到账中";

    }else{
        mS = @"已到账";

    }
    self.mStatus.text = mS;

}
@end
