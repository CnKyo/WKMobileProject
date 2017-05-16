//
//  WKFindHeaderCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
#import "RKImageBrowser.h"

@protocol WKFindHeaderCellDelegate <NSObject>

@optional

/**
 banner点击代理方法

 @param mIndex 返回索引
 */
- (void)WKFindHeaderCellDelegateWithBannerClicked:(NSInteger)mIndex;

/**
 功能按钮点击代理方法
 
 @param mIndex 返回索引
 */
- (void)WKFindHeaderCellDelegateWithFuncClicked:(NSInteger)mIndex;

/**
 搜索框文本代理方法
 
 @param mText 返回输入文本内容
 */
- (void)WKFindHeaderCellDelegateWithSearchText:(NSString *)mText;
///搜索按钮代理方法
- (void)WKFindHeaderCellDelegateWithSearchBtnClicked;

@end

@interface WKFindHeaderCell : UITableViewCell<UIScrollViewDelegate,UITextFieldDelegate>
{
    //第一页
    UIView *mBgkView1;
    //第二页
    UIView *mBgkView2;
    
    //    DCPicScrollView  *mScrollerView;
    RKImageBrowser  *mScrollerView;
    
    
    
}
///bannerview
//@property (weak, nonatomic) IBOutlet UIView *mBannerView;
///搜索view
//@property (weak, nonatomic) IBOutlet UIView *mSearchView;
///功能按钮view
//@property (weak, nonatomic) IBOutlet UIView *mFuncView;

@property (weak,nonatomic) id<WKFindHeaderCellDelegate>delegate;
/**
 重设cell的重用方法
 
 @param style           cell类型
 @param reuseIdentifier 重用id
 @param mDataSource     主功能按钮数据源
 
 @return 返回cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andBannerDataSource:(NSMutableArray *)mBannerDataSource andDataSource:(NSMutableArray *)mDataSource;

@end
