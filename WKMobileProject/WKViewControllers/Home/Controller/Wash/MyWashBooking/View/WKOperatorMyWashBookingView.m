//
//  WKOperatorMyWashBookingView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKOperatorMyWashBookingView.h"
#import "WKHeader.h"
#import <UIView+LayoutMethods.h>
@implementation WKOperatorMyWashBookingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKOperatorMyWashBookingView *)initview{
    WKOperatorMyWashBookingView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKOperatorMyWashBookingView" owner:self options:nil] objectAtIndex:0];
    [view.mBtnAction setButtonRoundedCornersWithView:view.superview andCorners:UIRectCornerAllCorners radius:3.0];
    view.mBgkView.layer.cornerRadius = view.mBgkView.ct_width/2;
    return view;
}

@end
