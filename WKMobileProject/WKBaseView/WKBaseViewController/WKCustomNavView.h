//
//  WKCustomNavView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCustomNavView : UIView
@property (weak, nonatomic) IBOutlet UIButton *mBackBtn;
@property (weak, nonatomic) IBOutlet UILabel *mTitle;


+ (WKCustomNavView *)initView;

@end
