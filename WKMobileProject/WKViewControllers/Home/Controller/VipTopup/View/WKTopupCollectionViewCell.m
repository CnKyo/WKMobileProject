//
//  WKTopupCollectionViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTopupCollectionViewCell.h"
#import "WKHeader.h"
@implementation WKTopupCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.mBgk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, (DEVICE_Width - 80) / 3, (DEVICE_Width - 80) / 3)];
        [self.mBgk setUserInteractionEnabled:true];
        self.mBgk.backgroundColor = [UIColor redColor];
        [self addSubview:self.mBgk];
        self.mName = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, (DEVICE_Width - 80) / 3, 45)];
        self.mName.numberOfLines = 2;
        [self.mName setUserInteractionEnabled:true];
        
        self.mName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.mName];
        self.mPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, (DEVICE_Width - 80) / 3, 20)];
        self.mPrice.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.mPrice];


        
        

    }
    return self;
}

@end
