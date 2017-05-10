
//
//  WKHomeHeaderSectionView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKHomeHeaderSectionView.h"

@implementation WKHomeHeaderSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (WKHomeHeaderSectionView *)initView{

    WKHomeHeaderSectionView *view = [[[NSBundle  mainBundle] loadNibNamed:@"WKHomeHeaderSectionView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

@end
