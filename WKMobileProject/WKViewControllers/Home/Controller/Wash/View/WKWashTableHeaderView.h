//
//  WKWashTableHeaderView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKWashTableHeaderViewDelegate <NSObject>

@optional

- (void)WKWashHeaderExtBtnAction:(NSInteger)mIndexPath;


@end

@interface WKWashTableHeaderView : UIView
///图标
@property (weak, nonatomic) IBOutlet UIImageView *mIcon;
///标题
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
///展开按钮
@property (weak, nonatomic) IBOutlet UIButton *mExtBtn;
///内容
@property (weak, nonatomic) IBOutlet UILabel *mContent;
///索引
@property (assign,nonatomic) NSInteger mIndexPath;

@property (weak,nonatomic) id<WKWashTableHeaderViewDelegate>delegate;

+ (WKWashTableHeaderView *)initView;

@end
