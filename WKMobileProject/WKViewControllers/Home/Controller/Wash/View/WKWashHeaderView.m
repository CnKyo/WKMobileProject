//
//  WKWashHeaderView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashHeaderView.h"

@implementation WKWashHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (WKWashHeaderView *)initView{
    WKWashHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKWashHeaderView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}
- (IBAction)booking:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WKWashHeaderViewBtnAction:)]) {
        [self.delegate WKWashHeaderViewBtnAction:1];

    }
}
- (IBAction)use:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WKWashHeaderViewBtnAction:)]) {
        [self.delegate WKWashHeaderViewBtnAction:3];
        
    }
}
- (IBAction)my:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WKWashHeaderViewBtnAction:)]) {
        [self.delegate WKWashHeaderViewBtnAction:2];
        
    }
}

@end
