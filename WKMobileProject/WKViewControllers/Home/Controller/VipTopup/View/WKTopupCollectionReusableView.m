//
//  WKTopupCollectionReusableView.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTopupCollectionReusableView.h"
#import "WKHeader.h"
@implementation WKTopupCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DEVICE_Width, 20)];
        self.title.textColor = [UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
    }
    return self;
}
@end
