//
//  WKRecordCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKRecordCell.h"

@implementation WKRecordCell

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
    
    self.mRecordMoneyTx.delegate = self;
    
    self.mCornerView.layer.masksToBounds = YES;
    self.mCornerView.layer.cornerRadius = 4;
    self.mCornerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mCornerView.layer.borderWidth = 1;
    
    self.mCommitBtn.layer.cornerRadius = 4;
    
    _mComPwdTx = [[WKPwdText alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
    [self.mPwdTxView addSubview:_mComPwdTx];
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.contentView endEditing:YES];
//    MLLog( @"222222----:%@", _mComPwdTx.text );
//    
//    if ([self.delegate respondsToSelector:@selector(WKRecordCellWithRecordPwd:)]) {
//        [self.delegate WKRecordCellWithRecordPwd:_mComPwdTx.text];
//        
//    }
//    
//    
//    
//}
- (IBAction)mBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(WKRecordCellWithRecordPwd:)]) {
        [self.delegate WKRecordCellWithRecordPwd:_mComPwdTx.text];
        
    }
    if ([self.delegate respondsToSelector:@selector(WKRecordCellWithRecordBtnClicked)]) {
        [self.delegate WKRecordCellWithRecordBtnClicked];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length>0) {
        if ([self.delegate respondsToSelector:@selector(WKRecordCellWithRecordMoney:)]) {
            [self.delegate WKRecordCellWithRecordMoney:textField.text];
        }
        
    }
}

@end
