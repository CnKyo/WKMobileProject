//
//  WKCustomNavView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKCustomNavView.h"

@implementation WKCustomNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKCustomNavView *)initView{
    WKCustomNavView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKCustomNavView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}
@end
