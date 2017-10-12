//
//  WKGoPayCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKGoPayCellDelegate <NSObject>

@optional

- (void)WKGoPayCellDelegateWithBtnAction:(NSInteger)mTag;

@end
@interface WKGoPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mWechatPay;
@property (weak, nonatomic) IBOutlet UIButton *mAlipay;
@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;
@property (weak,nonatomic) id<WKGoPayCellDelegate>delegate;

@end
