//
//  WKHomeDecomandedCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理方法
@protocol WKHomeDecomandedCellDelegate <NSObject>

@optional
///左边按钮的代理方法
- (void)WKHomeDecomandedCellDelegateWithLeftBtnClicked:(NSInteger)mIndex;
////右边按钮的代理方法
- (void)WKHomeDecomandedCellDelegateWithRightBtnClicked:(NSInteger)mIndex;

@end

///推荐cell
@interface WKHomeDecomandedCell : UITableViewCell
///左边的图片
@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;
///右边的图片
@property (weak, nonatomic) IBOutlet UIImageView *mrightImg;
///左边的按钮
@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;
///右边的按钮
@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;

@property (assign,nonatomic) NSInteger mIndex;

///设置代理
@property (weak,nonatomic) id<WKHomeDecomandedCellDelegate>delegate;

@end
