//
//  WKWashBookingCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashBookingCell.h"
#import "WKHeader.h"
@implementation WKWashBookingCell

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
    
    self.mBtn.layer.cornerRadius = 3;
}
- (IBAction)mBtnAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKWashBookingCellBtnAction:)]) {
        [self.delegate WKWashBookingCellBtnAction:self.mIndexPath];
    }
    
}

- (void)setMType:(WKWashBookingType)mType{

    if (mType == WKUnUsed) {
        self.mViewCenter.constant = -10;
        self.mContentCenter.constant = -10;
        self.mBtnCenter.constant = -10;
        self.mWaitingH.constant = 21;
        self.mWaiting.hidden = NO;
    }else{
        self.mViewCenter.constant = 0;
        self.mContentCenter.constant = 0;
        self.mBtnCenter.constant = 0;
        self.mWaitingH.constant = 0;
        self.mWaiting.hidden = YES;
    }
}
- (void)setMDeviceInfo:(MWDeviceInfo *)mDeviceInfo{
    
    if ([mDeviceInfo.device_status isEqualToString:@"1"]) {
        self.mBgkImg.image = [UIImage imageNamed:@"mang"];
        [self.mBtn setTitle:@"使用中" forState:0];
        [self.mBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.mBtn.enabled = NO;
    } else {
        self.mBgkImg.image = [UIImage imageNamed:@"kong"];
        [self.mBtn setTitle:@"选择" forState:0];
        [self.mBtn setBackgroundColor:[UIColor colorWithRed:0.25 green:0.58 blue:0.94 alpha:1]];
        self.mBtn.enabled = YES;
    }
    self.mContent.text = mDeviceInfo.location_name;
    
}
    
@end
