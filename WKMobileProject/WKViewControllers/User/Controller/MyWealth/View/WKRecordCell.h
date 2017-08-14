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

- (void)WKRecordCellWithRecordMoney:(NSString *)mText;

- (void)WKRecordCellWithRecordPwd:(NSString *)mText;

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
