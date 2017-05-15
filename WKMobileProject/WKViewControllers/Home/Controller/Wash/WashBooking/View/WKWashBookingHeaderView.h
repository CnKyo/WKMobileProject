//
//  WKWashBookingHeaderView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKWashBookingHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *mBkgView;
@property (weak, nonatomic) IBOutlet UILabel *mContent;
+ (WKWashBookingHeaderView *)initView;
@end
