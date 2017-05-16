//
//  WKBuyGoldCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBuyGoldCell.h"

@implementation WKBuyGoldCell

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

    self.mTxBgkView.layer.cornerRadius = 6.0f;
    self.mTxBgkView.layer.borderColor = [UIColor colorWithRed:0.807843137254902 green:0.835294117647059 blue:0.87843137254902 alpha:1.00].CGColor;
    self.mTxBgkView.layer.borderWidth = 0.5;
    
    
    self.mGoPayBtn.layer.cornerRadius = 3.0f;
    self.mFriendPayBtn.layer.cornerRadius = 3.0f;
    
    self.mNumTx.delegate = self;
    
}

- (IBAction)mSeclectedBtn:(UIButton *)sender {
    [_mTypeArr removeAllObjects];
    
    switch (sender.tag) {
        case 1:
        {
        if (sender.selected == NO) {
            self.mWechatBtn.selected = YES;
            self.mAlipayBtn.selected = NO;
            
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
            self.mAlipayBtn.selected = YES;
            
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
    
    if ([self.delegate respondsToSelector:@selector(WKBuyGoldCellDelegateWithPayType:)]) {
        [self.delegate WKBuyGoldCellDelegateWithPayType:mtype];
    }
    

}

- (IBAction)mGoPayType:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKBuyGoldCellDelegateIsGoPayOrFriendPayBtnClicked:)]) {
        [self.delegate WKBuyGoldCellDelegateIsGoPayOrFriendPayBtnClicked:sender.tag];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length>0) {
        if ([self.delegate respondsToSelector:@selector(WKBuyGoldCellDelegateCurrentTextField:)]) {
            [self.delegate WKBuyGoldCellDelegateCurrentTextField:textField.text];
        }
        
    }
}

@end
