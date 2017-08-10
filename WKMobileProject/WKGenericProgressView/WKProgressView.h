//
//  WKProgressView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"

typedef enum WKProgressStatus {
    ///错误
    WKProgressError,
    ///成功
    WKProgressSucess
} WKProgressStatus;


@class WKProgressView;

typedef void(^WKProgressBlock)(WKProgressView *progressView,NSInteger btnIndex);

@interface WKProgressView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *mStatusImg;

@property (weak, nonatomic) IBOutlet UILabel *mTitle;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

@property (weak, nonatomic) IBOutlet UIButton *mFirstBtn;

@property (weak, nonatomic) IBOutlet UIView *mBottomView;

@property (weak, nonatomic) IBOutlet UIButton *mSecondBtn;

@property (nonatomic,copy) WKProgressBlock mProgressBlock;

+ (void)WKShowView:(UIView *)mView andStatus:(WKProgressStatus)mStatus WithTitle:(NSString *)mTitle andContent:(NSString *)mContent andBtnTitle:(NSString *)mBtnTitle andImgSRC:(NSString *)mImgSRC andBlock:(WKProgressBlock)block;

@end
