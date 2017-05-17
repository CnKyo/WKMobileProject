//
//  WKJoinusHeaderFooterSectionView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKJoinusHeaderFooterSectionView.h"

@implementation WKJoinusHeaderFooterSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKJoinusHeaderFooterSectionView *)initHeaderView{
    WKJoinusHeaderFooterSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKJoinusHeaderSectionView" owner:self options:nil] objectAtIndex:0];
    return view;
}

+ (WKJoinusHeaderFooterSectionView *)initFooterView{
    WKJoinusHeaderFooterSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKJoinusFooterSectionView" owner:self options:nil] objectAtIndex:0];
    view.mJoinBtn.layer.cornerRadius = 3.0f;
    return view;
}
@end
