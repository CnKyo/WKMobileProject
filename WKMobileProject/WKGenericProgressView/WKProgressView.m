//
//  WKProgressView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKProgressView.h"

@implementation WKProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)WKShowView:(UIView *)mView andStatus:(WKProgressStatus)mStatus WithTitle:(NSString *)mTitle andContent:(NSString *)mContent andBtnTitle:(NSString *)mBtnTitle andImgSRC:(NSString *)mImgSRC andBlock:(WKProgressBlock)block{
    WKProgressView *view = [self shareView:mView];
    [view removeFromSuperview];
    view.alpha = 1;
    view.mTitle.text = mTitle;
    view.mContent.text = mContent;
    view.mProgressBlock = block;
    [view.mFirstBtn setTitle:mBtnTitle forState:0];
    [view.mSecondBtn setTitle:mBtnTitle forState:0];
    view.mStatusImg.image = [UIImage imageNamed:mImgSRC];
    if (mStatus == WKProgressSucess) {
        view.backgroundColor = M_BCO;
        view.mTitle.textColor = [UIColor whiteColor];
        view.mContent.textColor = [UIColor whiteColor];
        
        view.mFirstBtn.hidden = YES;
        view.mStatusImg.hidden = YES;
        view.mBottomView.hidden = NO;
        view.mSecondBtn.hidden = NO;
    
    }else{
        view.backgroundColor = [UIColor whiteColor];
        view.mTitle.textColor = [UIColor lightGrayColor];
        view.mContent.textColor = [UIColor lightGrayColor];
        
        view.mFirstBtn.hidden = NO;
        view.mStatusImg.hidden = NO;
        view.mBottomView.hidden = YES;
        view.mSecondBtn.hidden = YES;
    }
    [mView addSubview:view];
}
+ (WKProgressView *)shareView:(UIView *)mView{
    WKProgressView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKProgressView" owner:self options:nil] objectAtIndex:0];
    view.mFirstBtn.layer.cornerRadius = view.mSecondBtn.layer.cornerRadius = 4;
    view.backgroundColor = M_BCO;
    view.frame = mView.bounds;
    return view;
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if (self.mProgressBlock) {
        self.mProgressBlock(self, sender.tag);
    }
    [self dismiss];
}
- (void)dismiss
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.alpha = 0.0f;
    }];
}
@end
