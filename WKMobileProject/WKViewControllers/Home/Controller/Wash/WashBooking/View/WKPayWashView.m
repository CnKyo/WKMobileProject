//
//  WKPayWashView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKPayWashView.h"

#import "WKHeader.h"
@implementation WKPayWashView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (WKPayWashView *)initView{

    WKPayWashView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKPayWashView" owner:self options:nil] objectAtIndex:0];
    
    [view.mPayBtn setButtonRoundedCornersWithView:view.superview andCorners:UIRectCornerAllCorners radius:3.0];
    
    return view;
}
- (IBAction)payAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(WKPayWashViewDelegateWithPayBtnClicked)]) {
        [self.delegate WKPayWashViewDelegateWithPayBtnClicked];
    }

}

- (IBAction)selectedPayType:(UIButton *)sender {
    [_mPayTypeArr removeAllObjects];

    switch (sender.tag) {
        case 1:
        {
        if (sender.selected == NO) {
            self.mWechatBtn.selected = YES;
            self.mAlipayBtn.selected = NO;
            self.mCoinBtn.selected = NO;
     
            [_mPayTypeArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        }else{
            
            sender.selected = NO;
            [_mPayTypeArr removeAllObjects];
        }

        }
            break;
        case 2:
        {
        if (sender.selected == NO) {
            self.mWechatBtn.selected = NO;
            self.mAlipayBtn.selected = YES;
            self.mCoinBtn.selected = NO;
            
            [_mPayTypeArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        }else{
            
            sender.selected = NO;
            [_mPayTypeArr removeAllObjects];
        }
        }
            break;
        case 3:
        {
        if (sender.selected == NO) {
            self.mWechatBtn.selected = NO;
            self.mAlipayBtn.selected = NO;
            self.mCoinBtn.selected = YES;
            
            [_mPayTypeArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        }else{
            
            sender.selected = NO;
            [_mPayTypeArr removeAllObjects];
        }
        }
            break;
            
        default:
            break;
    }
    
    NSInteger mtype = 0;
    
    
    if (_mPayTypeArr!=nil) {
        mtype = [[NSString stringWithFormat:@"%@",_mPayTypeArr[0]] integerValue];
    }else{
        mtype = 0;
    }

    if ([self.delegate respondsToSelector:@selector(WKPayWashViewDelegateCurrentPayType:)]) {
        [self.delegate WKPayWashViewDelegateCurrentPayType:mtype];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _mPayTypeArr = [NSMutableArray new];
}

@end
