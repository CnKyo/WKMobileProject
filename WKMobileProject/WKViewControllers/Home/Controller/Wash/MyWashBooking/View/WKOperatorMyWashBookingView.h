//
//  WKOperatorMyWashBookingView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WKOperatorMyWashBookingView : UIView
@property (weak, nonatomic) IBOutlet UIView *mBgkView;

@property (weak, nonatomic) IBOutlet UILabel *mCountTime;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

@property (weak, nonatomic) IBOutlet UIButton *mBtnAction;

+ (WKOperatorMyWashBookingView *)initview;

@end
