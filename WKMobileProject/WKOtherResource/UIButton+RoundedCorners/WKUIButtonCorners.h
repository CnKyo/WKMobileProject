//
//  WKUIButtonCorners.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/22.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (RoundedCorners)
-(void)setButtonRoundedCornersWithView:(UIView *)mView andCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end
