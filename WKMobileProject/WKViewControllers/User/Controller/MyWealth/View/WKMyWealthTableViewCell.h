//
//  WKMyWealthTableViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLButton.h"
#import "WKHeader.h"
///设置代理
@protocol WKMyWealthTableViewCellDelegate <NSObject>

@optional

/**
 按钮点击代理事件

 @param mTag 返回按钮tag(0说明，1绑定，2提现 )
 */
- (void)WKMyWealthTableViewCellBtnClickedWithTag:(NSInteger)mTag;

@end

@interface WKMyWealthTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
///总财富值
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTotleWealth;
///财富说明
@property (weak, nonatomic) IBOutlet YLButton *mexplain;
///财富值-已到账
@property (weak, nonatomic) IBOutlet UILabel *mWealthAlreadyToMoney;
///财富值-到账中
@property (weak, nonatomic) IBOutlet UILabel *mWealthIng;
///提现-已到账
@property (weak, nonatomic) IBOutlet UILabel *mWithDrawAlreadyToMoney;
///提现-到账中
@property (weak, nonatomic) IBOutlet UILabel *mWithDrawIng;
///绑定收款工具
@property (weak, nonatomic) IBOutlet UIButton *mBoundleTool;
///提现按钮
@property (weak, nonatomic) IBOutlet UIButton *mDrawBtn;
///设置代理
@property (weak,nonatomic) id<WKMyWealthTableViewCellDelegate>delegate;

@end
