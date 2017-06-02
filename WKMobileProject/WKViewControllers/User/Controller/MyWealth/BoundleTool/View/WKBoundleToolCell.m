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
    
    _mPwdTx= [[WKPasswordTextFiled alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
    [self.mPwdView addSubview:_mPwdTx];
    
    _mComPwdTx = [[WKPwdText alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
    [self.mComfirmPwdView addSubview:_mComPwdTx];

    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.contentView endEditing:YES];
    MLLog( @"111111----:%@", _mPwdTx.text );
    MLLog( @"222222----:%@", _mComPwdTx.text );
    
    if (_mPwdTx.text.length>0) {
        if ([_delegate respondsToSelector:@selector(WKBoundleToolCellDelegateWithTag:WithPwdText:)]) {
            [_delegate WKBoundleToolCellDelegateWithTag:1 WithPwdText:_mPwdTx.text];
        }
        
    }else{
        if ([_delegate respondsToSelector:@selector(WKBoundleToolCellDelegateWithTag:WithPwdText:)]) {
            [_delegate WKBoundleToolCellDelegateWithTag:2 WithPwdText:_mComPwdTx.text];
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
