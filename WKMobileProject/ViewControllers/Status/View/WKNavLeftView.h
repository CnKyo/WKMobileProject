//
//  WKNavLeftView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKNavLeftViewDelegate <NSObject>

@optional

- (void)WKNavLeftViewDelegateWithBtnAction;

@end

@interface WKNavLeftView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mWetherImg;
@property (weak, nonatomic) IBOutlet UIButton *mWetherDetail;

@property (weak,nonatomic) id<WKNavLeftViewDelegate>delegate;

+ (WKNavLeftView *)initView;
@end
