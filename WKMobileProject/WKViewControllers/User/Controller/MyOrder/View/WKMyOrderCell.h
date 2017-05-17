//
//  WKMyOrderCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKMyOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mOrderCode;

@property (weak, nonatomic) IBOutlet UILabel *mOrderTime;

@property (weak, nonatomic) IBOutlet UIImageView *mImg;

@property (weak, nonatomic) IBOutlet UILabel *mOrderName;

@property (weak, nonatomic) IBOutlet UILabel *mGold;

@property (weak, nonatomic) IBOutlet UILabel *mNum;

@property (weak, nonatomic) IBOutlet UILabel *mStatus;


@end
