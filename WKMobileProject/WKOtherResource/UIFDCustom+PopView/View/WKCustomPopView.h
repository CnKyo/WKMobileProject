//
//  WKUIButtonCorners.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/5/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
///设置代理
@protocol WKCustomPopViewDelegate <NSObject>

@optional
///关闭按钮代理方法
- (void)WKCustomPopViewWithCloseBtnAction;
///取消按钮代理方法
- (void)WKCustomPopViewWithCancelBtnAction;
///确定按钮代理方法
- (void)WKCustomPopViewWithOkBtnAction;

@end

@interface WKCustomPopView : UIView
///标题view
@property (weak, nonatomic) IBOutlet UIView *mTitleView;
///标题
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
///内容view
@property (weak, nonatomic) IBOutlet UILabel *mContentView;
///确定按钮
@property (weak, nonatomic) IBOutlet UIButton *mBtn;
///左边的按钮
@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;
///右边的按钮
@property (weak, nonatomic) IBOutlet UIButton *mrightBtn;

/**
 初始化view

 @param mType 显示类型
 @param mTitle 显示标题
 @param mContent 显示内容
 @param mOkTitle 确定按钮标题
 @param mCancelTitle 取消按钮标题
 @return 返回view
 */
+ (WKCustomPopView *)initViewType:(WKCustomPopViewType)mType andTitle:(NSString *)mTitle andContentTx:(NSString *)mContent andOkBtntitle:(NSString *)mOkTitle andCancelBtntitle:(NSString *)mCancelTitle;
///设置代理
@property (weak,nonatomic) id<WKCustomPopViewDelegate>delegate;

@end
