//
//  WKHomeTypeHeaderCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
#import "RKImageBrowser.h"

@protocol WKHomeTypeHeaderCellDelegate <NSObject>

@optional

/**
 跑马灯点击的代理方法
*/
- (void)WKHomeScrollerLabelDidSelected;

/**
 主功能按钮点击的代理方法
 
 @param mIndex 索引
 */
- (void)WKHomeScrollerTableViewCellDidSelectedWithIndex:(NSInteger)mIndex;

/**
 点击baner的代理方法
 
 @param mIndex 索引
 */
- (void)WKHomeBannerDidSelectedWithIndex:(NSInteger)mIndex;


@end

@interface WKHomeTypeHeaderCell : UITableViewCell<UIScrollViewDelegate>
{
    //第一页
    UIView *mBgkView1;
    //第二页
    UIView *mBgkView2;
    
    //    DCPicScrollView  *mScrollerView;
    RKImageBrowser  *mScrollerView;
    
    
    
}


/**
 重设cell的重用方法
 
 @param style           cell类型
 @param reuseIdentifier 重用id
 @param mDataSource     主功能按钮数据源
 @param mText     跑马灯文本

 @return 返回cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andBannerDataSource:(NSMutableArray *)mBannerDataSource andDataSource:(NSMutableArray *)mDataSource andScrollerLabelTx:(NSString *)mText;

/**
 cell的代理
 */
@property (strong,nonatomic) id <WKHomeTypeHeaderCellDelegate>delegate;
@end
