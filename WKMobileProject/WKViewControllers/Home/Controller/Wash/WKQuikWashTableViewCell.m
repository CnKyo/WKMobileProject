//
//  WKQuikWashTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKQuikWashTableViewCell.h"

@implementation WKQuikWashTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    self.mTextField.delegate = self;
    self.mCodeBtn.layer.cornerRadius = self.mScanBtn.layer.cornerRadius = 4;
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(WKQuikWashDelegateWithAddressBookBtnClicked:)]) {
        [self.delegate WKQuikWashDelegateWithAddressBookBtnClicked:sender.tag];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length>0) {
        if ([self.delegate respondsToSelector:@selector(WKQuikWashDelegateWithTextFieldEndEdit:)]) {
            [self.delegate WKQuikWashDelegateWithTextFieldEndEdit:textField.text
             ];
        }
        
    }
    
}
@end
