//
//  WKMyTaskDetailCommitCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQTextView.h>

@protocol WKMyTaskDetailCommitCellDelagate <NSObject>

@optional

/**
 cell按钮代理方法

 @param mTag 1:微信转发。  2:外网注册。  3：立即提交。
 */
- (void)WKMyTaskDetailCommitCellWithBtnClicked:(NSInteger)mTag;

/**
 cell备注输入框代理方法

 @param mText 返回输入内容
 */
- (void)WKMyTaskDetailCommitCellWithTextViewEndEditing:(NSString *)mText;


@end

@interface WKMyTaskDetailCommitCell : UITableViewCell<UITextViewDelegate>

/**
 微信按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mWechatBtn;

/**
 外网注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mOutLineRegistBtn;

@property (weak, nonatomic) IBOutlet UIImageView *mWechatImg;

@property (weak, nonatomic) IBOutlet UIImageView *mOutLineRegistImg;

/**
 资料录入view
 */
@property (weak, nonatomic) IBOutlet UIView *mWriteDataView;

/**
 立即提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCommitNowBtn;

/**
 倒计时
 */
@property (weak, nonatomic) IBOutlet UILabel *mCountTime;

@property (weak, nonatomic) IBOutlet IQTextView *mNoteTxView;

@property (weak,nonatomic) id<WKMyTaskDetailCommitCellDelagate>delegate;

@end
