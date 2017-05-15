//
//  WKWashHeaderView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKWashHeaderViewDelegate <NSObject>

@optional

- (void)WKWashHeaderViewBtnAction:(NSInteger)mTag;

@end

@interface WKWashHeaderView : UIView

+ (WKWashHeaderView *)initView;

@property(weak,nonatomic) id<WKWashHeaderViewDelegate>delegate;

@end
