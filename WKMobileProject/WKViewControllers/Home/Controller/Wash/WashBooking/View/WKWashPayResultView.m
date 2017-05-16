//
//  WKWashPayResultView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashPayResultView.h"
#import "WKHeader.h"

@implementation WKWashPayResultView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKWashPayResultView *)initSucessView{

    WKWashPayResultView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKWashPayResultView" owner:self options:nil] objectAtIndex:0];
    [view.mBackBtn setButtonRoundedCornersWithView:view.superview andCorners:UIRectCornerAllCorners radius:3.0];

    return view;
}
+ (WKWashPayResultView *)initErrorView{
    WKWashPayResultView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKWashPayErrorView" owner:self options:nil] objectAtIndex:0];
    [view.mRebookingBtn setButtonRoundedCornersWithView:view.superview andCorners:UIRectCornerAllCorners radius:3.0];
    
    return view;
}
- (IBAction)mBackAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKWashPayResultViewWithBackAction)]) {
        [self.delegate WKWashPayResultViewWithBackAction];
    }
    
}
+ (WKWashPayResultView *)initVIPSucessView{
    WKWashPayResultView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKVIPTopupSucessView" owner:self options:nil] objectAtIndex:0];
    view.mVipBgk.layer.cornerRadius = view.mVipBgk.ct_width/2;
    return view;
}

@end
