//
//  MyWashDetailCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "MyWashDetailCell.h"

@implementation MyWashDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMWashObj:(MWWashOrderObj *)mWashObj{
    NSString *mS = @"";
    if ([mWashObj.order_type isEqualToString:@"2"]) {
        mS = @"进行中";
        self.mReason.textColor = [UIColor lightTextColor];
    }else if([mWashObj.order_type isEqualToString:@"3"]){
        mS = @"超时返还";
        self.mReason.textColor = [UIColor colorWithRed:0.29 green:0.6 blue:0.94 alpha:1];
    }else{
        mS = @"已完成";
        self.mReason.textColor = [UIColor lightTextColor];
    }
    self.mReason.text = [NSString stringWithFormat:@"订单状态：%@",mS];
//    NSDictionary* style1 = @{@"color": [UIColor colorWithRed:0.97 green:0.58 blue:0.27 alpha:1]};
    self.mWashType.text = [NSString stringWithFormat:@"洗衣类型：%@   %@元",mWashObj.wash_feature_name,mWashObj.order_price];
    self.mWashAddress.text = [NSString stringWithFormat:@"洗衣地址：%@",mWashObj.location_name];
    self.mPayTime.text = [NSString stringWithFormat:@"付款时间：%@",[Util WKTimeIntervalToDate:mWashObj.add_time]];
    self.mWashTime.text = [NSString stringWithFormat:@"预约洗衣时间：%@",mWashObj.wash_time];

    
}
@end
