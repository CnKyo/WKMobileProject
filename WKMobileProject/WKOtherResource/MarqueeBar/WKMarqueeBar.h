//
//  WKMarqueeBar.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/1.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

/*********************************
 *
 *  支持Storyboard，xib，支持Autolayout 、masonry。手动赋值title属性。
 *
 *********************************/

@interface WKMarqueeBar : UIView
@property (nonatomic, strong) NSString  * title;
@property (nonatomic, strong) UIButton  * btn;
@property (nonatomic, strong) UIColor   * tintColor;
@property (nonatomic, strong) UIFont    * textFont;
@property (copy,nonatomic) void (^block)(UIButton *);
+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString*)title action:(void(^)(UIButton *btn))block;
- (void)addBtnAction:(void(^)(UIButton *btn))block;
- (void)updateTitle:(NSString*)title;
@end
