
//
//  WKWashTableHeaderView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashTableHeaderView.h"

@implementation WKWashTableHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (WKWashTableHeaderView *)initView{
    WKWashTableHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKWashTableHeaderView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}
- (IBAction)mExtAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WKWashHeaderExtBtnAction:)]) {
        [self.delegate WKWashHeaderExtBtnAction:self.mIndexPath];
    }
    
}

@end
