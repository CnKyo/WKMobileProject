//
//  WKOperatorMyWashBookingView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"



@interface WKOperatorMyWashBookingView : UIView<MZTimerLabelDelegate>
@property (weak, nonatomic) IBOutlet UIView *mBgkView;

@property (weak, nonatomic) IBOutlet MZTimerLabel *mCountTime;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

@property (weak, nonatomic) IBOutlet UIButton *mBtnAction;

+ (WKOperatorMyWashBookingView *)initview;

@end
