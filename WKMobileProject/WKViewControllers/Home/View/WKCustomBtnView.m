//
//  WKCustomBtnView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKCustomBtnView.h"
#import <UIImageView+WebCache.h>
#import "WKHeader.h"

@implementation WKCustomBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithZLCustomBtnViewFrame:(CGRect)mFrame Title:(NSString *)mTitle ImageStr:(NSString *)mImageStr{
    self = [super initWithFrame:mFrame];
    if (self) {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(mFrame.size.width/2-20, 15, 35, 37)];
        
        //        [imageView sd_setImageWithURL:[NSURL URLWithString:mImageStr] placeholderImage:[UIImage imageNamed:@"ZLDefault_Green"]];
        if ([Util isUrl:mImageStr]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:mImageStr] placeholderImage:[UIImage imageNamed:@"ZLDefault_Green"]];
            
            
        }else{
            imageView.image = [UIImage imageNamed:mImageStr];
            
        }
        
        
        
        [self addSubview:imageView];
        
        //
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+44, mFrame.size.width, 20)];
        titleLable.text = mTitle;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLable];
        
    }
    return self;
    
}

@end
