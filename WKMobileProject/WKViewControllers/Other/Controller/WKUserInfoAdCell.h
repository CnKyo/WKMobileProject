//
//  WKUserInfoAdCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKUserInfoAdCellDelegate <NSObject>

@optional
/**
 左边按钮点击代理方法
 
 @param mIndexPath 返回索引
 */
- (void)WKUserInfoAdCellDelegateWithLeftBtn:(NSIndexPath *)mIndexPath;
/**
 右边按钮点击代理方法
 
 @param mIndexPath 返回索引
 */
- (void)WKUserInfoAdCellDelegateWithRightBtn:(NSIndexPath *)mIndexPath;
@end

@interface WKUserInfoAdCell : UITableViewCell
///左边的图片
@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;
///左边的按钮
@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;
///右边的图片
@property (weak, nonatomic) IBOutlet UIImageView *mRightImg;
///右边的按钮
@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;
///索引
@property (strong,nonatomic) NSIndexPath *mIndexPath;
///
@property (weak,nonatomic)id<WKUserInfoAdCellDelegate>delegete;

@end
