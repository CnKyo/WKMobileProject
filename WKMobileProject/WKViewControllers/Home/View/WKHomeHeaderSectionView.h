//
//  WKHomeHeaderSectionView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKHomeHeaderSectionView : UIView
///标题
@property (weak, nonatomic) IBOutlet UILabel *mTitle;

+ (WKHomeHeaderSectionView *)initView;

@end
