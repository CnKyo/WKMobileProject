//
//  WKGoPayCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKGoPayCell.h"

@implementation WKGoPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _mTypeArr = [NSMutableArray new];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)mBtnAction:(UIButton *)sender {
    
    [_mTypeArr removeAllObjects];
    
    switch (sender.tag) {
        case 0:
        {
        if (sender.selected == NO) {
            self.mWechatPay.selected = YES;
            self.mAlipay.selected = NO;
            
            [_mTypeArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
        }else{
            
            sender.selected = NO;
            [_mTypeArr removeAllObjects];
        }
        
        }
            break;
        case 1:
        {
        if (sender.selected == NO) {
            self.mWechatPay.selected = NO;
            self.mAlipay.selected = YES;
            
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
    NSInteger mT;
    if (sender.tag == 2) {
        mT = sender.tag;
    }else{
        
        mT = mtype;
    }
    if([self.delegate respondsToSelector:@selector(WKGoPayCellDelegateWithBtnAction:)]) {
        [self.delegate WKGoPayCellDelegateWithBtnAction:mT];
    }

    
}

@end
