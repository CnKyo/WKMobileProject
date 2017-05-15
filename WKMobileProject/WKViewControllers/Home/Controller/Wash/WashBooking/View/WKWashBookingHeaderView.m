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
    view.mBkgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.mBkgView.layer.borderWidth = 1;
    return view;
    
}

@end
