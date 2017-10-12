//
//  WKExchangeBarcodeView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKExchangeBarcodeView.h"

@implementation WKExchangeBarcodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKExchangeBarcodeView *)initView{
    
    WKExchangeBarcodeView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKExchangeBarcodeView" owner:self options:nil] objectAtIndex:0];
    return view;
}

@end
