//
//  WKJoinusHeaderFooterSectionView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKJoinusHeaderFooterSectionView : UIView

#pragma mark----****---- header
///兼职图片
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
///兼职名称
@property (weak, nonatomic) IBOutlet UILabel *mName;

+ (WKJoinusHeaderFooterSectionView *)initHeaderView;

#pragma mark----****---- footer
///加入按钮
@property (weak, nonatomic) IBOutlet UIButton *mJoinBtn;

+ (WKJoinusHeaderFooterSectionView *)initFooterView;
@end
