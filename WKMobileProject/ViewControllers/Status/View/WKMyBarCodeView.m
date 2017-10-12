//
//  WKMyBarCodeView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyBarCodeView.h"

@implementation WKMyBarCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKMyBarCodeView *)initView{
    
    WKMyBarCodeView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKMyBarCodeView" owner:self options:nil] objectAtIndex:0];
    return view;
}
@end
