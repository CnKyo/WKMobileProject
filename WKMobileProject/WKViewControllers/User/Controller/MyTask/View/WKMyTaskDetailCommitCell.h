//
//  WKMyTaskDetailCommitCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
#import <IQTextView.h>

#import <LLImagePickerView.h>

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

/**
 选择图片代理方法

 @param mImgArr 返回图片数组
 */
- (void)WKMyTaskDetailCommitCellWithReturnImgs:(NSArray *)mImgArr;

@end

@interface WKMyTaskDetailCommitCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mUpLoadView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mUploadViewH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mNoteH;


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

- (void)initPickView;
@end
