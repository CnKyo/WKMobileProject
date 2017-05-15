//
//  WKWashPayResultView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理
@protocol WKWashPayResultViewDelegate <NSObject>

@optional
///按钮代理方法
- (void)WKWashPayResultViewWithBackAction;

@end

@interface WKWashPayResultView : UIView
///状态
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
///内容
@property (weak, nonatomic) IBOutlet UILabel *mDetail;
///倒计时
@property (weak, nonatomic) IBOutlet UILabel *mCountTime;
///返回按钮
@property (weak, nonatomic) IBOutlet UIButton *mBackBtn;
///重新预约按钮
@property (weak, nonatomic) IBOutlet UIButton *mRebookingBtn;
///设置代理
@property (weak,nonatomic) id<WKWashPayResultViewDelegate>delegate;
///初始化成功view
+ (WKWashPayResultView *)initSucessView;
///初始化失败view
+ (WKWashPayResultView *)initErrorView;


@end
