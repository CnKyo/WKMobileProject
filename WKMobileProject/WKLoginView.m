//
//  WKLoginView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/27.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKLoginView.h"

@implementation WKLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKLoginView *)shareView{
    
    WKLoginView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKLoginView" owner:self options:nil] objectAtIndex:0];
    view.mAcountTx.delegate = view.mPwdTx.delegate = view;
    
    view.mTextBgkView.layer.cornerRadius = 4;
    
    view.mLoginBtn.layer.cornerRadius = 4;
    
    return view;
}

- (IBAction)mBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(WKLoginViewBtnActions:)]) {
        [self.delegate WKLoginViewBtnActions:sender.tag];
    }
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField.text.length>0) {
        if ([self.delegate respondsToSelector:@selector(WKLoginViewTextFieldDidEndEditing:currentText:)]) {
            [self.delegate WKLoginViewTextFieldDidEndEditing:textField.tag currentText:textField.text];
        }
        
    }
}


@end
