//
//  WKCustomBtnView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCustomBtnView : UIView
/**
 初始化自定义方法
 
 @param mFrame    frame位置
 @param mTitle    标题
 @param mImageStr 图片
 
 @return 返回self
 */
-(id)initWithZLCustomBtnViewFrame:(CGRect)mFrame Title:(NSString *)mTitle ImageStr:(NSString *)mImageStr;
@end
