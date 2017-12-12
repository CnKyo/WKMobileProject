//
//  WKAlertView.h
//  WKMobileProject
//
//  Created by wangke on 2017/12/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#define showView_Width [UIScreen mainScreen].bounds.size.width * 0.8
#define showView_Height 225

//按钮
typedef NS_ENUM(NSUInteger, WKAlertActionStyle) {
    WKAlertActionCancel, //取消
    WKAlertActionConfirm, //确认
    
};
@interface WKAlertAction:NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) WKAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@property(nonatomic,copy)void(^handler)(WKAlertAction *);
+ (instancetype)actionTitle:(NSString *)title style:(WKAlertActionStyle)style handler:(void(^)(WKAlertAction *action))handler;

@end
@interface WKAlertView : UIView

//btn Color
@property(nonatomic,strong)UIColor *butttonCancelBgColor;
@property(nonatomic,strong)UIColor *butttonConfirmBgColor;

#pragma mark----****----初始化控制器
/**
 初始化控制器
 
 @param mTitle 标题
 @param mTextColor 标题内容颜色
 @param mLineColor 线颜色
 @param mTitleBgkColor 标题背景颜色
 @param mHideCloseBtn 是否隐藏x按钮
 @param mHideLine 是否隐藏线
 @param mRadius 控件圆角
 @param mMessage 显示信息详情
 @return 返回控件
 */
+ (instancetype)alertTitle:(NSString *)mTitle andTitleTextColor:(UIColor *)mTextColor andLineViewColor:(UIColor *)mLineColor andTitleBgkColor:(UIColor *)mTitleBgkColor andHideCloseBtn:(BOOL)mHideCloseBtn andHideLineView:(BOOL)mHideLine andCornerRadius:(CGFloat)mRadius andMessage:(NSString *)mMessage;

- (void)addAction:(WKAlertAction *)action;

-(void)show;

-(void)hide;
@end
