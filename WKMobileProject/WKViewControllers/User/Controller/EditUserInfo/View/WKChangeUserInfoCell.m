//
//  WKChangeUserInfoCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKChangeUserInfoCell.h"

@implementation WKChangeUserInfoCell

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
    self.mCodeBtn.layer.cornerRadius = self.mCommitBtn.layer.cornerRadius = 4;

    self.mEditTextField.delegate =self.mPhoneTx.delegate =self.mCodeTx.delegate =self.mNewPwdTx.delegate =self.mComfirmNewPwd.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length>0 && ![textField.text isEqualToString:@" "]) {
        if ([self.delegate respondsToSelector:@selector(WKChangeUserInfoCellWithTextFieldEndEditingWithTextFieldTag:andText:)]) {
            [self.delegate WKChangeUserInfoCellWithTextFieldEndEditingWithTextFieldTag:textField.tag andText:textField.text];

        }
    }
}
- (IBAction)btnAction:(UIButton *)sender {
    if (sender.tag == 1) {
        [self timeCount];
    }
    if ([self.delegate respondsToSelector:@selector(WKChangeUserInfoCellWithBtnClickTag:)]) {
        [self.delegate WKChangeUserInfoCellWithBtnClickTag:sender.tag];
    }
    
}

- (void)timeCount{//倒计时函数
    
    [self.mCodeBtn setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    _timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.mCodeBtn.frame.size.width, self.mCodeBtn.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置//UILabel设置成和UIButton一样的尺寸和位置
    [self.mCodeBtn addSubview:_timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:_timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒后再试";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:14];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    self.mCodeBtn.userInteractionEnabled = NO;//按钮禁止点击
    [self.mCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
    
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [self.mCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [_timer_show removeFromSuperview];//移除倒计时模块
    self.mCodeBtn.userInteractionEnabled = YES;//按钮可以点击
    [self.mCodeBtn setBackgroundColor:M_CO];
    
    
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
