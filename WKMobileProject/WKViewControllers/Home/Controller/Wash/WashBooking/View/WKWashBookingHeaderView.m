//
//  WKWashBookingHeaderView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashBookingHeaderView.h"

@implementation WKWashBookingHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (WKWashBookingHeaderView *)initView{
    WKWashBookingHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"WKWashBookingHeaderView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mBkgView.layer.cornerRadius = 5;
    view.mBkgView.layer.borderColor = [UIColor colorWithRed:0.807843F green:0.835294F blue:0.878431F alpha:0.5f].CGColor;
    view.mBkgView.layer.borderWidth = 1;
    return view;
    
}
+ (WKWashBookingHeaderView *)initBookingView{
    WKWashBookingHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"WKBookingResultView" owner:self options:nil] objectAtIndex:0];
 
    return view;
}


@end
