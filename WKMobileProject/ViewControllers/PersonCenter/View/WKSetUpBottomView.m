//
//  WKSetUpBottomView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKSetUpBottomView.h"

@implementation WKSetUpBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKSetUpBottomView *)initView{
    WKSetUpBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKSetUpBottomView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}
@end
