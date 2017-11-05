//
//  ZYProGressView.m
//  ProgressBar
//
//  Created by Apple on 2017/4/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZYProGressView.h"

@interface ZYProGressView()
{
    UIView *viewTop;
    UIView *viewBottom;
}

@end
@implementation ZYProGressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self buildUI];
        
    }
    return self;
}

- (void)buildUI
{
    
    viewBottom = [[UIView alloc]initWithFrame:self.bounds];
    viewBottom.backgroundColor = [UIColor colorWithRed:0.58 green:0.76 blue:0.96 alpha:1];
    viewBottom.layer.cornerRadius = 3;
    viewBottom.layer.masksToBounds = YES;
    [self addSubview:viewBottom];
    
    
    viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, viewBottom.frame.size.height)];
    viewTop.backgroundColor = [UIColor whiteColor];
    viewTop.layer.cornerRadius = 3;
    viewTop.layer.masksToBounds = YES;
    [viewBottom addSubview:viewTop];
    
}


-(void)setTime:(float)time
{
    _time = time;
}
-(void)setProgressValue:(NSString *)progressValue
{
    if (!_time) {
        _time = 3.0f;
    }
    _progressValue = progressValue;
    [UIView animateWithDuration:_time animations:^{
        viewTop.frame = CGRectMake(viewTop.frame.origin.x, viewTop.frame.origin.y, viewBottom.frame.size.width*[progressValue floatValue], viewTop.frame.size.height);
    }];
}


-(void)setBottomColor:(UIColor *)bottomColor
{
    _bottomColor = bottomColor;
    viewBottom.backgroundColor = bottomColor;
}

-(void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    viewTop.backgroundColor = progressColor;
}












@end
