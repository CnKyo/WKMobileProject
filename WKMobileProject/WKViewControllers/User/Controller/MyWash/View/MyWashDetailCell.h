//
//  MyWashDetailCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWashDetailCell : UITableViewCell
///洗衣类型
@property (weak, nonatomic) IBOutlet UILabel *mWashType;
///洗衣地址
@property (weak, nonatomic) IBOutlet UILabel *mWashAddress;
///付款时间
@property (weak, nonatomic) IBOutlet UILabel *mPayTime;
///洗衣时间
@property (weak, nonatomic) IBOutlet UILabel *mWashTime;
///原因
@property (weak, nonatomic) IBOutlet UILabel *mReason;

@end
