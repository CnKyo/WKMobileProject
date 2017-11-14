//
//  WKUserInfoCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserInfoCell.h"
#import "WKHeader.h"
@implementation WKUserInfoCell

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
    self.contentView.backgroundColor = M_BCO;
    [self.mSignBtn setButtonRoundedCornersWithView:self.contentView andCorners:UIRectCornerAllCorners radius:3.0];
    [self.mAvator zy_cornerRadiusRoundingRect];
}
- (IBAction)mHeadBtnAction:(UIButton *)sender {
    if ([self.delegete respondsToSelector:@selector(WKUserInfoCellDelegateWithBtnClicked:)]) {
        [self.delegete WKUserInfoCellDelegateWithBtnClicked:sender.tag];
    }
    
}

- (void)setMPressValue:(NSString *)mPressValue{
    [self.mProgress removeFromSuperview];
    self.mProgress = [[ZYProGressView alloc]initWithFrame:CGRectMake(0, 0, self.mProgressView.frame.size.width, self.mProgressView.frame.size.height)];
    self.mProgress.progressValue = mPressValue;
    [self.mProgressView addSubview:self.mProgress];
}

- (void)setMUserInfo:(WKUser *)mUserInfo{
    self.mTreasure.text = [NSString stringWithFormat:@"%@",mUserInfo.rewards];
    self.mGold.text = [NSString stringWithFormat:@"%@个",mUserInfo.gold];
    self.mUserName.text = [NSString stringWithFormat:@"%@  %@",mUserInfo.nickname,mUserInfo.mobile];
    [self.mAvator sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mUserInfo.user_img]] placeholderImage:nil];
    
}
- (void)setMSign:(BOOL)mSign{
    if (mSign == YES) {
        [self.mSignBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.mSignBtn.enabled = NO;
        [self.mSignBtn setTitle:@"已签到" forState:0];
    }else{
        [self.mSignBtn setBackgroundColor:[UIColor colorWithRed:0.97 green:0.58 blue:0.27 alpha:1]];
        self.mSignBtn.enabled = YES;
        [self.mSignBtn setTitle:@"签到" forState:0];
    }
}
@end
