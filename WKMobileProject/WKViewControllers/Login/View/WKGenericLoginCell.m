//
//  WKGenericLoginCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKGenericLoginCell.h"

@implementation WKGenericLoginCell

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
    
    self.mGetVerifyCodeBtn.layer.cornerRadius = self.mLoginBtn.layer.cornerRadius = self.mRegistBtn.layer.cornerRadius = 4;
    
    self.mUserNameTx.delegate = self.mPwdTx.delegate = self.mVerifyCodeTx.delegate = self.mComfirmPwdTx.delegate = self.mSharePersonPhoneTx.delegate = self.mSchoolTx.delegate = self;
}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKGenericRegistCellDelegateWithBtnAction:)]) {
        [self.delegate WKGenericRegistCellDelegateWithBtnAction:sender.tag];
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([self.delegate respondsToSelector:@selector(WKGenericRegistCellDelegateWithTextFieldEditingWithTag:andText:)]) {
        [self.delegate WKGenericRegistCellDelegateWithTextFieldEditingWithTag:textField.tag andText:textField.text];
    }
    
}
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///密码输入长度
#define PASS_LENGHT 20
#define CODE_LENGTH 6
#define DEFAULT_LENGTH 50

#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11 || textField.tag == 17) {
        res= TEXT_MAXLENGTH-[new length];
        
    }else if(textField.tag == 20)
        {
        res= PASS_LENGHT-[new length];
        
        }
    else if(textField.tag == 6)
        {
        res= CODE_LENGTH-[new length];
        
        }
    else {
        res= DEFAULT_LENGTH-[new length];

    }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}
@end
