//
//  WKNavLeftView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKNavLeftView.h"

@implementation WKNavLeftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKNavLeftView *)initView{
    
    WKNavLeftView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKNavLeftView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(WKNavLeftViewDelegateWithBtnAction)]) {
        [self.delegate WKNavLeftViewDelegateWithBtnAction];
    }
    
}
@end
