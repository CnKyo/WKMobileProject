//
//  WKWashBookingHeaderView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKCountLabel.h"
#import "MZTimerLabel.h"

@interface WKWashBookingHeaderView : UIView<MZTimerLabelDelegate>
#pragma mark----****----洗衣机首页
///背景view
@property (weak, nonatomic) IBOutlet UIView *mBkgView;
///内容
@property (weak, nonatomic) IBOutlet UILabel *mContent;
///选择学校
@property (weak, nonatomic) IBOutlet UIButton *mSelectedShollBtn;
    
///初始化view
+ (WKWashBookingHeaderView *)initView;
#pragma mark----****----洗衣机预约
///倒计时
@property (weak, nonatomic) IBOutlet MZTimerLabel *mCountTime;
///状态按钮
@property (weak, nonatomic) IBOutlet UIButton *mStatusBtn;
///洗衣地址
@property (weak, nonatomic) IBOutlet UILabel *mWashAddress;
///洗衣机状态
@property (weak, nonatomic) IBOutlet UILabel *mWashStatus;
///选中按钮
@property (weak, nonatomic) IBOutlet UILabel *mWashSeclected;
///初始化预约view
+ (WKWashBookingHeaderView *)initBookingView;
    
    


@end
