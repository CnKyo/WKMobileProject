//
//  WKTopupHeaderView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTopupHeaderView.h"

@implementation WKTopupHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (WKTopupHeaderView *)initview{
    WKTopupHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKTopupHeaderView" owner:self options:nil] objectAtIndex:0];
    view.mTopupTx.delegate = view;
    return view;
}

- (IBAction)mAddressBookAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WKTopupHeaderViewDelegateWithAddressBookBtnClicked)]) {
        [self.delegate WKTopupHeaderViewDelegateWithAddressBookBtnClicked];
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField.text.length>0) {
        if ([self.delegate respondsToSelector:@selector(WKTopupHeaderViewDelegateWithTextFieldEndEdit:)]) {
            [self.delegate WKTopupHeaderViewDelegateWithTextFieldEndEdit:textField.text
             ];
        }
        
    }
    
}
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    {
        res= TEXT_MAXLENGTH-[new length];
        
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
