//
//  WKBoundleToolCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBoundleToolCell.h"

@implementation WKBoundleToolCell

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

    
    _mArr = [NSMutableArray new];
    self.mCommitBtn.layer.cornerRadius = 3;
    
    _mPwdTx = [WKPwdTextField new];
    _mPwdTx.frame = CGRectMake(35, 0, DEVICE_Width-70, 50);
    _mPwdTx.delegate = self;
    _mPwdTx.secureTextEntry = YES;
    _mPwdTx.autoResignFirstResponderWhenInputFinished = YES;
    _mPwdTx.unitSpace = 10;
    _mPwdTx.borderRadius = 4;
    _mPwdTx.borderWidth = 1;
    
    _mPwdTx.textColor = [UIColor blackColor];
    _mPwdTx.tintColor = [UIColor colorWithRed:0.850980392156863 green:0.850980392156863 blue:0.850980392156863 alpha:1.00];
    _mPwdTx.trackTintColor = [UIColor colorWithRed:0.850980392156863 green:0.850980392156863 blue:0.850980392156863 alpha:1.00];
    _mPwdTx.cursorColor = [UIColor blueColor];

    [self.mPwdView addSubview:_mPwdTx];
    
    _mComPwdTx = [WLUnitField new];
    _mComPwdTx.frame = CGRectMake(35, 0, DEVICE_Width-70, 50);
    _mComPwdTx.delegate = self;
    _mComPwdTx.secureTextEntry = YES;
    _mComPwdTx.autoResignFirstResponderWhenInputFinished = YES;
    _mComPwdTx.unitSpace = 10;
    _mComPwdTx.borderRadius = 4;
    _mComPwdTx.borderWidth = 1;
    
    _mComPwdTx.textColor = [UIColor blackColor];
    _mComPwdTx.tintColor = [UIColor colorWithRed:0.850980392156863 green:0.850980392156863 blue:0.850980392156863 alpha:1.00];
    _mComPwdTx.trackTintColor = [UIColor colorWithRed:0.850980392156863 green:0.850980392156863 blue:0.850980392156863 alpha:1.00];
    _mComPwdTx.cursorColor = [UIColor blueColor];
    
    [self.mComfirmPwdView addSubview:_mComPwdTx];

    
    
}
- (BOOL)unitField:(WLUnitField *)uniField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [uniField.text stringByAppendingString:string];
    
    if (text.length>=6) {
        NSLog(@"第一个内容是：******>%@", text);
        if ([_delegate respondsToSelector:@selector(WKBoundleToolCellDelegateWithTag:WithPwdText:)]) {
            [_delegate WKBoundleToolCellDelegateWithTag:2 WithPwdText:text];
        }
    }
    
    
    return YES;
}
- (BOOL)WKunitField:(WKPwdTextField *)uniField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = [uniField.text stringByAppendingString:string];
    
    if (text.length>=6) {
        NSLog(@"第一个内容是：******>%@", text);
        if ([_delegate respondsToSelector:@selector(WKBoundleToolCellDelegateWithTag:WithPwdText:)]) {
            [_delegate WKBoundleToolCellDelegateWithTag:1 WithPwdText:text];
        }
    }
    
    
    return YES;

}

//- (void)unitFieldEditingChanged:(WLUnitField *)sender {
//    NSLog(@"%s, ----得到的内容是：%@", __FUNCTION__, sender.text);
//    
//}
//
//- (void)unitFieldEditingDidBegin:(id)sender {
//    NSLog(@"%s", __FUNCTION__);
//}
//
//- (void)unitFieldEditingDidEnd:(id)sender {
//    NSLog(@"%s", __FUNCTION__);
//}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.contentView endEditing:YES];
    MLLog( @"222222----:%@", _mComPwdTx.text );
    
    if (_mPwdTx.text.length>0) {
        if ([_delegate respondsToSelector:@selector(WKBoundleToolCellDelegateWithTag:WithPwdText:)]) {
            [_delegate WKBoundleToolCellDelegateWithTag:1 WithPwdText:_mPwdTx.text];
        }
        
    }
    
}
- (IBAction)typeBtnAction:(UIButton *)sender {
    [_mArr removeAllObjects];
    
    switch (sender.tag) {
        case 1:
        {
        if (sender.selected == NO) {
            self.mWechatBtn.selected = YES;
            self.mAlipayBtn.selected = NO;
            
            [_mArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
        }else{
            
            sender.selected = NO;
            [_mArr removeAllObjects];
        }
        
        }
            break;
        case 2:
        {
        if (sender.selected == NO) {
            self.mWechatBtn.selected = NO;
            self.mAlipayBtn.selected = YES;
            
            [_mArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        }else{
            
            sender.selected = NO;
            [_mArr removeAllObjects];
        }
        
        }
            break;
        default:
            break;
    }
    
    NSInteger mtype = 0;
    
    if (_mArr.count>0) {
        mtype = [[NSString stringWithFormat:@"%@",_mArr[0]] integerValue];
    }else{
        mtype = 0;
    }
    
    if ([self.delegate respondsToSelector:@selector(WKBoundleToolCellDelegateDidSelectedType:)]) {
        [self.delegate WKBoundleToolCellDelegateDidSelectedType:mtype];
    }

}

- (IBAction)mCommitAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(WKBoundleToolCellDelegateWithCommitAction)]) {
        [_delegate WKBoundleToolCellDelegateWithCommitAction];
    }
    
}

@end
