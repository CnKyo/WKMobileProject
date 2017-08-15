//
//  WKRecordCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKPwdText.h"
#import "WKHeader.h"

@protocol  WKRecordCellDelegate <NSObject>

@optional

/**
 提现金额代理方法

 @param mText 返回金额内容
 */
- (void)WKRecordCellWithRecordMoney:(NSString *)mText;

/**
 提现密码代理方法

 @param mText 返回密码输入内容
 */
- (void)WKRecordCellWithRecordPwd:(NSString *)mText;

/**
 提现按钮代理方法
 */
- (void)WKRecordCellWithRecordBtnClicked;

@end

@interface WKRecordCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mMMoney;

@property (weak, nonatomic) IBOutlet UILabel *mToolName;

@property (weak, nonatomic) IBOutlet UILabel *mAcount;

@property (weak, nonatomic) IBOutlet UIView *mCornerView;

@property (weak, nonatomic) IBOutlet UITextField *mRecordMoneyTx;

@property (weak, nonatomic) IBOutlet UIView *mPwdTxView;

@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;

@property (strong,nonatomic) WKPwdText *mComPwdTx;

@property (weak,nonatomic) id <WKRecordCellDelegate>delegate;


@end
