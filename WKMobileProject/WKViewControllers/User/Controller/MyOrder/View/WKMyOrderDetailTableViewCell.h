//
//  WKMyOrderDetailTableViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
@interface WKMyOrderDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mOrderCode;

@property (weak, nonatomic) IBOutlet UIImageView *mOrderImg;

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mPayPrice;

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mCreatOrderTime;

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mPayTime;

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mUserName;

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mPayType;

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mOrderStatus;

@end
