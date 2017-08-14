//
//  WKTaskSectionHeaderView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTaskSectionHeaderView.h"

@implementation WKTaskSectionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKTaskSectionHeaderView *)initView{
    WKTaskSectionHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKTaskSectionHeaderView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

+ (WKTaskSectionHeaderView *)initActivityView{

    WKTaskSectionHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKActivityDetailHeadView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}
@end
