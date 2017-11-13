
//
//  WKPayVIPTopupCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKPayVIPTopupCell.h"

@implementation WKPayVIPTopupCell

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
    _mTypeArr = [NSMutableArray new];
    
    //    [self.mGoPayBtn setButtonRoundedCornersWithView:self.contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
    //    [self.mFriendPayBtn setButtonRoundedCornersWithView:self.contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
    
    self.mGoPayBtn.layer.cornerRadius = 3.0;
    self.mFriendPayBtn.layer.cornerRadius = 3.0;
}
- (IBAction)mSelectedPayType:(UIButton *)sender {
    [_mTypeArr removeAllObjects];
    
    switch (sender.tag) {
        case 1:
        {
        if (sender.selected == NO) {
            self.mWechatBtn.selected = YES;
            self.mAlipaybtn.selected = NO;
            
            [_mTypeArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
        }else{
            
            sender.selected = NO;
            [_mTypeArr removeAllObjects];
        }
        
        }
            break;
        case 2:
        {
        if (sender.selected == NO) {
            self.mWechatBtn.selected = NO;
            self.mAlipaybtn.selected = YES;
            
            [_mTypeArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        }else{
            
            sender.selected = NO;
            [_mTypeArr removeAllObjects];
        }
        
        }
            break;
        default:
            break;
    }
    
    NSInteger mtype = 0;
    
    if (_mTypeArr.count>0) {
        mtype = [[NSString stringWithFormat:@"%@",_mTypeArr[0]] integerValue];
    }else{
        mtype = 0;
    }
    
    if ([self.delegate respondsToSelector:@selector(WKPayVIPTopupCellDelegeteWithPayType:)]) {
        [self.delegate WKPayVIPTopupCellDelegeteWithPayType:mtype];
    }
    
}

- (IBAction)mGoPay:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKPayVIPTopupCellDelegeteIsGoPayOrFriendPayBtnClicked:)]) {
        [self.delegate WKPayVIPTopupCellDelegeteIsGoPayOrFriendPayBtnClicked:sender.tag];
    }
    
}

@end
