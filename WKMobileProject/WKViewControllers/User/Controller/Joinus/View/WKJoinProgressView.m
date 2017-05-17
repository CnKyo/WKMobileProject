//
//  WKJoinProgressView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKJoinProgressView.h"

@implementation WKJoinProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKJoinProgressView *)initView{
    WKJoinProgressView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKJoinProgressView" owner:self options:nil] objectAtIndex:0];
    view.mBackBtn.layer.cornerRadius = 3.0;
    return view;
}

@end
