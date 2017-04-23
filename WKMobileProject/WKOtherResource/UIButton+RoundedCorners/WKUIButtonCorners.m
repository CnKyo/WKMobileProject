//
//  WKUIButtonCorners.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/22.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUIButtonCorners.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIButton (RoundedCorners)

-(void)setButtonRoundedCornersWithView:(UIView *)mView andCorners:(UIRectCorner)corners radius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = mView.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.layer.mask = maskLayer;

}

@end
